.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2025                                    .
.. ...........................................................................

.. _basic-concepts:

==========================
Ansible for IBM Z Glossary
==========================

These terms are used often when with Ansible, familiarizing yourself with them
will help you understand the Ansible for IBM Z documentation and communicate effectively.

.. glossary::

    ansible-core
        The installable package that contains the command-line tools and the
        code for basic features and functions that initiate the interaction with
        the managed node. The ansible-core package includes a few modules and
        plugins and allows you to add others by installing collections.

    Control node
        The machine from which you run Ansible commands, manage playbooks, and
        control the automation process. It can be any machine that meets the
        software requirements - laptops, shared desktops, servers or
        Ansible Automation Platform. Multiple control nodes are possible.

    Managed node
        Also known as a host, is any device or system that Ansible manages through
        automation tasks. It is the endpoint where Ansible modules are executed to
        perform various configurations and operations identified
        in :term:`inventory<Inventory>`

    Collection
        A structured format that packages multiple sources of related Ansible content,
        such as roles, modules, plugins, and playbooks, into a single distributable
        unit. Collections provide a way to simplify the distribution and reuse
        of Ansible content. To learn more, see `Using Ansible collections`_.

    Module
        The code in Ansible that performs a particular operation on a managed node.
        Modules are invoked by tasks within Ansible playbooks. They generally execute
        on the :term:`managed node<Managed node>` unless delegated to execute on
        ``localhost``.

    Plugin
        A piece of reusable code that extends the functionality of Ansible. Plugins
        enable additional features and customization, they execute on the
        :term:`control node<Control node>`. For more information,see `Working with plugins`_.

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

    Group Vars
        The group_vars/ files are files that live in a directory alongside an
        inventory file, with an optional file name named after each group. This
        is a convenient place to put variables that are provided to a given group,
        especially complex data structures, so that these variables do not have to
        be embedded in the inventory file or :term:`playbook<Playbook>`.

    Host Vars
        Just like Group Vars, a directory alongside the inventory file named
        ``host_vars/`` can contain a file named after each hostname in the inventory
        file, in YAML format. This provides a convenient place to assign variables
        to the host without having to embed them in the inventory file. The
        Host Vars file can also be used to define complex data structures that
        can't be represented in the inventory file.

.. ...........................................................................
.. External links:
.. ...........................................................................
.. _Building Ansible inventories: https://docs.ansible.com/ansible/latest/inventory_guide/index.html#
.. _Ansible playbooks: https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_intro.html#about-playbooks
.. _Working with plugins: https://docs.ansible.com/ansible/latest/plugins/plugins.html#working-with-plugins
.. _Using Ansible collections: https://docs.ansible.com/ansible/latest/collections_guide/index.html#collections