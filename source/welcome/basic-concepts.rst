.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

.. _basic-concepts:

================
Ansible glossary
================

These concepts are common to all uses of Ansible®. You should understand them
before using Ansible for IBM Z® or reading the documentation.

.. glossary::

    ansible-core
        The installable package that contains the command-line tools and the
        code for basic features and functions that initiate the interaction with
        the managed node. The ansible-core package includes a few modules and
        plugins and allows you to add others by installing collections.

    Control node
        The machine from which you run Ansible commands, manage playbooks, and
        control the automation process. It can be any machine that meets the
        software requirements - laptops, shared desktops, or servers. Multiple
        control nodes are possible.

    Managed node
        Also known as a host, is any device or system that Ansible manages through
        automation tasks. It is the endpoint where Ansible modules are executed to
        perform various configurations and operations.

    Collection
        A structured format that packages multiple related Ansible content, such
        as roles, modules, plugins, and playbooks, into a single distributable
        unit. Collections provide a way to simplify the distribution and reuse
        of Ansible content. To learn more, see `Using Ansible collections`_.

    Module
        The code in Ansible that performs a particular operation on a managed node.
        Modules are invoked by tasks within Ansible playbooks.

    Plugin
        A piece of reusable code that extends the functionality of Ansible. Plugins
        enable additional features and customization. For more information,
        see `Working with plugins`_.

    Role
        A way to package and organize related Ansible content (tasks, variables, files,
        templates, and handlers) into a reusable format. To use any role, the role
        must first be imported into the play.

    Playbook
        A YAML file that contains one or more plays, each of which defines a set
        of tasks to be executed on specified hosts. Playbook orchestrate the
        execution of these tasks. To learn more, see `Ansible playbooks`_.

    Play
        The basic unit of Ansible execution. It is a key component of a playbook
        that maps managed nodes to tasks. It contains variables, roles, and an
        ordered list of tasks. It can be run repeatedly.

    Task
        The definition of an action to be executed on managed nodes. Tasks use modules
        with specific parameters to perform specific operations, such as installing
        packages or copying files.

    Inventory
        A configuration file or directory that specifies the hosts and group of
        hosts on which Ansible commands, modules, and playbooks will operate. It
        also defines variables and connection details for those hosts, such as
        IP address. For more information, see `Building Ansible inventories`_.

    Ansible Galaxy
        An online distribution server for hosting Ansible community content.
        It is also the command-line utility that lets users install individual
        Ansible Collections.

.. ...........................................................................
.. External links:
.. ...........................................................................
.. _Building Ansible inventories: https://docs.ansible.com/ansible/latest/inventory_guide/index.html#
.. _Ansible playbooks: https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html#about-playbooks
.. _Working with plugins: https://docs.ansible.com/ansible/latest/plugins/plugins.html#working-with-plugins
.. _Using Ansible collections: https://docs.ansible.com/ansible/latest/collections_guide/index.html#collections