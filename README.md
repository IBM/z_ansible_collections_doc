# z_ansible_collections_doc
Repository for Z collections documentation is a repository for all Ansible Z
collections which come together under one unified offering.

# Instructions
  Clone the repository, ensure you have all the requirements to allow you to
  build and generate documentation. See the requirements.txt if you want to
  simply PIP install the requirements into your host which is not recommended.
  It is better to use a Python virtual environment (venv); for that I have
  supplied a script (setup.sh) that will check the python level, clone python
  repo if needed, build and start a venv then install all the requirements. This
  script only supports Mac OS. Feel free to port or review the commands for
  other distributions.

  After all requirements are installed, you can run the playbook in the order
  listed below. Do not check in updated .gitmodules, nor any generated HTHML.
  Of course, you will need WRITE permissions to check-in anything anyhow and
  only a few admins have those permissions.

  If you follow the playbook order below where `site-uploader.yml` is optional,
  you will generate doc, it will be displayed in your hosts browser then you
  will be prompted to upload to git-pages which requires that you have write
  permissions to the repository. When you are finished, run the
  `site-teardown.yml` playbook so that the repository remains in a minimal state
  and ready for the next update.

## Playbook run order
   1. `ansible-playbook -i inventory site-builder.yml`
      1. This will checkout the latest code from every collection in the
         `registry.yml`. It will then begin extracting and creating HTML doc,
         then display it in your local browser, and if configured and permitted
         will commit and push the change to Git so it is live. By default, it
         does not push to Git and it requires permissions.
   2. ansible-playbook -i inventory site-uploader.yml --ask-vault-pass
      1. Optional playbook that when the password is provided at the prompt,
         the generated documentation will be uploaded to an internal private
         Apache server to be hosted and shared with others who might want to
         review the documentation before committing and pushing it to Git.
   3. ansible-playbook -i inventory site-teardown.yml
      1. This will undo all the changes in the submodules restoring the file
         and configuration back to a minimal original state. This avoids issues
         that can happen when the `registry.yml` is updated with a temporary
         private branch. In other words, this resets your local environment back
         to how it was when you cloned it. Lastly, it removes any generated
         HTML.
