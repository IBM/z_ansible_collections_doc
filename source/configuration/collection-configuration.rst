Prerequisites
=============
Before installing any collection, ensure the collection requirements are met through the use of `environment variables`_. The preferred configuration is to place the environment variables in ``group_vars`` and ``host_vars``, you can find examples of this configuration under **Configuration** of any project in the `Ansible Z Playbook Repository`_.

.. note::
    If you are testing a configuration, it can be helpful to set the environment variables in a playbook. See `How to put environment variables in a playbook`_.

To install ZOAU Python wheel, see `Python wheel installation method`_.


.. ...........................................................................
.. External links
.. ...........................................................................
.. _environment variables:
   https://github.com/IBM/z_ansible_collections_samples/blob/main/docs/share/zos_core/configuration_guide.md#environment-variables
.. _Ansible Z Playbook Repository:
   https://github.com/IBM/z_ansible_collections_samples
.. _How to put environment variables in a playbook:
   https://github.com/ansible-collections/ibm_zos_core/discussions/657
.. _Python wheel installation method:
   https://www.ibm.com/docs/en/zoau/1.3.x?topic=installing-zoau#python-wheel-installation-method
.. _Installing collections (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-collections
.. _Configuring the ansible-galaxy client (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#configuring-the-ansible-galaxy-client
.. _Ansible Configuration Settings (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/reference_appendices/config.html
.. _Installing a collection from a git repository (Ansible Documentation):
   https://docs.ansible.com/ansible/latest/collections_guide/collections_installing.html#installing-a-collection-from-a-git-repository
.. _Connect to Hub:
   https://cloud.redhat.com/ansible/automation-hub/token/
.. _Creating the API token in automation hub:
    https://docs.redhat.com/en/documentation/red_hat_ansible_automation_platform/2.4/html/getting_started_with_automation_hub/hub-create-api-token#hub-create-api-token
