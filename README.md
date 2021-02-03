# z_ansible_collections_doc
Repository for Z collections documentation

# Instructions
  Clone the repository, ensure you have all the requirements to allow you to
  build and generate documentation. See the requirements.txt if you want to
  simply PIP install the requirements into your host which is not recommended.
  It is better to use a Python virtual environment, for that I have supplied a
  setup.sh script that will run thus far only on a Mac.

  After all requirements are installed, you can run the playbook in the order
  listed below. Do not check in updated .gitmodules, nor any generated HTHML.

  If you follow the playbook order below where `site-uploader.yml` is optional,
  you will generate doc, it will be displayed in your hosts browser then you
  will be prompted to upload to git-pages which requires that you have write
  permissions to the repository. When you are finished, run the site-teardown
  playbook so that the repository remains in a minimal state and ready for
  the next update.

## Playbook run order
   1. ansible-playbook -i inventory site-builder.yml
   1. ansible-playbook -i inventory site-uploader.yml --ask-vault-pass
   1. ansible-playbook -i inventory site-teardown.yml
