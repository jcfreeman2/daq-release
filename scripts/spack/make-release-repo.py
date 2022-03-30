#!/usr/bin/env python3

import os
import yaml
import argparse
import shutil
import subprocess
import tempfile


class MyDumper(yaml.Dumper):

    def increase_indent(self, flow=False, indentless=False):
        return super(MyDumper, self).increase_indent(flow, False)


def parse_yaml_file(fname):
    if not os.path.exists(fname):
        print("Error: -- YAML file {} does not exist".format(fname))
        exit(20)
    fman = ""
    with open(fname, 'r') as stream:
        try:
            fman = yaml.safe_load(stream)
        except yaml.YAMLError as exc:
            print(exc)
    return fman


def check_output(cmd):
    irun = subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE,
                            stderr=subprocess.PIPE)
    out = irun.communicate()
    rc = irun.returncode
    if rc != 0:
        print('\nERROR: command "{}" has exit non-zero exit status,\
please check!\n'.format(cmd))
        print('Command output:\n {}\n'.format(out[0].decode('utf-8')))
        print('Command error:\n{}\n'.format(out[1].decode('utf-8')))

        exit(10)
    return out


def get_commit_hash(repo, tag_or_branch):
    tmp_dir = tempfile.mkdtemp()
    cmd = f"""cd {tmp_dir}; \
        git clone --quiet https://github.com/DUNE-DAQ/{repo}.git; cd {repo}; \
        git checkout --quiet {tag_or_branch}; \
        git rev-parse --short HEAD"""
    output = check_output(cmd)
    shutil.rmtree(tmp_dir)
    commit_hash = output[0].decode('utf-8').strip()
    print(f"Info: updating commit hash for {repo} with commit hash {commit_hash}")
    cmd = "cd /tmp; rm -rf daq_repo_*"
    output = check_output(cmd);
    return commit_hash


class DAQRelease:

    def __init__(self, yaml_file):
        self.yaml = yaml_file
        self.rdict = parse_yaml_file(self.yaml)

    def copy_release_yaml(self, repo_path, update_hash=False):
        repo_dir = os.path.join(repo_path, self.rdict["release"])
        os.makedirs(repo_dir, exist_ok=True)
        self.yaml = shutil.copy2(self.yaml, repo_dir)
        # Now modify self.yaml and update self.rdict
        if update_hash:
            for i in range(len(self.rdict["dunedaq"])):
                ipkg = self.rdict["dunedaq"][i]
                iname = ipkg["name"]
                irepo = f"https://github.com/DUNE-DAQ/{iname}"
                iver = ipkg["version"]
                ihash = ipkg["commit"]
                if iver != "develop":
                    itag = 'v' + iver
                else:
                    itag = iver
                ihash = get_commit_hash(iname, iver)
                self.rdict["dunedaq"][i]["commit"] = ihash
            # rewrite YAML
            with open(self.yaml, 'w') as outfile:
                yaml.dump(self.rdict, outfile, Dumper=MyDumper, default_flow_style=False, sort_keys=False)
        return

    def generate_repo_file(self, repo_path):
        repo_dir = os.path.join(repo_path, self.rdict["release"])
        os.makedirs(repo_dir, exist_ok=True)
        with open(os.path.join(repo_dir, "repo.yaml"), 'w') as f:
            repo_string = "repo:\n  namespace: '{}'\n".format(
                self.rdict["release"])
            f.write(repo_string)
        return

    def generate_daq_package(self, repo_dir, template_dir):
        repo_dir = os.path.join(repo_dir, self.rdict["release"], "packages")
        template_dir = os.path.join(template_dir, "packages")
        for ipkg in self.rdict["dunedaq"]:
            itemp = os.path.join(template_dir, ipkg["name"], 'package.py')
            if not os.path.exists(itemp):
                print(f"Error: template file {itemp} is not found!")
                continue
            with open(itemp, 'r') as f:
                lines = f.read()
                lines = lines.replace("VERSION", ipkg["version"])
                lines = lines.replace("HASH", ipkg["commit"])
                # get commit hash
            ipkg_dir = os.path.join(repo_dir, ipkg["name"])
            os.makedirs(ipkg_dir)
            ipkgpy = os.path.join(ipkg_dir, "package.py")
            with open(ipkgpy, 'w') as o:
                o.write(lines)
                print(f"Info: package.py has been written at {ipkgpy}.")
        return

    def generate_umbrella_package(self, repo_dir, template_dir):
        repo_dir = os.path.join(repo_dir, self.rdict["release"], "packages")
        template_dir = os.path.join(template_dir, "packages")
        for ipkg in ['devtools', 'externals', 'systems', 'dunedaq']:
            itemp = os.path.join(template_dir, ipkg, 'package.py')
            if not os.path.exists(itemp):
                print(f"Error: template file {itemp} is not found!")
                continue
            with open(itemp, 'r') as f:
                lines = f.read()
                lines = lines.replace("RELEASE", self.rdict["release"])

            # now add additional deps:
            if ipkg == 'dunedaq':
                lines += '\n    for build_type in ["Debug", "RelWithDebInfo", "Release"]:'
            for idep in self.rdict[ipkg]:
                iname = idep["name"]
                iver = idep["version"]
                if ipkg != 'dunedaq':
                    ivar = idep["variant"]
                    if ivar == None:
                        lines += f'\n    depends_on("{iname}@{iver}")'
                    else:
                        lines += f'\n    depends_on("{iname}@{iver} {ivar}")'
                else:
                    lines += f'\n        depends_on(f"{iname}@{iver} build_type={{build_type}}", when=f"build_type={{build_type}}")'
            lines += '\n'
            ipkg_dir = os.path.join(repo_dir, ipkg)
            os.makedirs(ipkg_dir)
            ipkgpy = os.path.join(ipkg_dir, "package.py")
            with open(ipkgpy, 'w') as o:
                o.write(lines)
                print(f"Info: package.py has been written at {ipkgpy}.")
        return


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        prog='make-release-repo.py',
        description="Parse DUNE DAQ release manifest files.",
        epilog="Questions and comments to dingpf@fnal.gov",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument('-t', '--template-path',
                        default="../../spack-repos/packages",
                        help='''path to the template directory;''')
    parser.add_argument('-i', '--input-manifest', required=True,
                        help="path to the release manifest file;")
    parser.add_argument('-u', '--update-hash', action='store_true',
                        help="whether to update commit hash in the YAML file;")
    parser.add_argument('-o', '--output-path', required=True,
                        help="path for the generated repo;")

    args = parser.parse_args()

    daq_release = DAQRelease(args.input_manifest)
    daq_release.copy_release_yaml(args.output_path, args.update_hash)
    daq_release.generate_repo_file(args.output_path)
    daq_release.generate_daq_package(args.output_path, args.template_path)
    daq_release.generate_umbrella_package(args.output_path, args.template_path)
