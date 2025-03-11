.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2021                                    .
.. ...........................................................................

.. _collection releases:

===================
Collection Releases
===================

Each of the Ansible for IBM Z collections includes version specific release
notes, select a collection to review the release notes.

.. toctree::
   :maxdepth: 1
   :hidden:

   z/OS Core </../ibm_zos_core/docs/source/release_notes>
   z/OS CICS </../ibm_zos_cics/docs/source/release_notes>
   z/OS IMS </../ibm_zos_ims/docs/source/release_notes>
   z/OS Sys Auto <../ibm_zos_sysauto/docs/source/release_notes>
   z/OS z/OSMF <../ibm_zosmf/docs/source/release_notes>
   Z HMC </../zhmc-ansible-modules/docs/source/release_notes>

.. grid:: 1 1 2 2
    :gutter: 1

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: z/OS Core release notes :octicon:`link-external`
               :link: ../ibm_zos_core/docs/source/release_notes.html

               Click to review the collections release notes.

            .. grid-item-card:: z/OS IMS release notes :octicon:`link-external`
               :link: ../ibm_zos_ims/docs/source/release_notes.html

               Click to review the collections release notes.

            .. grid-item-card:: z/OS CICS release notes :octicon:`link-external`
               :link: ../ibm_zos_cics/docs/source/release_notes.html

               Click to review the collections release notes.

    .. grid-item::

        .. grid:: 1 1 1 1
            :gutter: 1

            .. grid-item-card:: z/OSMF release notes :octicon:`link-external`
               :link: ../ibm_zosmf/docs/source/release_notes.html

               Click to review the collections release notes.

            .. grid-item-card:: Z HMC release notes :octicon:`link-external`
               :link: ../zhmc-ansible-modules/docs/source/release_notes.html

               Click to review the collections release notes.

            .. grid-item-card:: z/OS System Automation release notes :octicon:`link-external`
               :link: ../ibm_zos_sysauto/docs/source/release_notes.html

               Click to review the collections release notes.


A collections release notes can include several of the following topics, to see more expand
the descriptions below.

.. dropdown:: A collections release notes can include any of the following ... (expand for more)
    :color: success
    :icon: command-palette

        These are the topics the release notes will included when applicable.

        New Modules
              - Includes the new modules that have released in the collection.
        New Plugins
              - Includes the new plugins that have released in the collection
        Major Changes
              - Includes non-breaking changes that impact all or most
                of the collection, EOL announcement and upcoming breaking changes. A
                major change means a user can choose to when to update but are not
                required to do so.
        Minor Changes
              - Are enhancements to modules, they are not considered
                bugs. They include changes to modules or plugins such as new
                parameters, non-breaking behavioral changes to existing parameters;
                for example, adding a new option to a choice.
        Breaking Changes / Porting Guide
              - Include changes that break existing
                playbooks or roles, any change that would force a user to update playbook
                tasks. These only occur in a major release of a collection.
        Deprecated Features
              - Include any features that are scheduled for removal in a future release.
        Removed Features (after being deprecated)
              - Include features that were previously deprecated and are now removed.
        Security Fixes
              - Include fixes that address `CVEs`_ or resolve security concerns.
        Bugfixes
              - Include fixes that resolve issues.
        Known Issues
              - Include issues that known and  currently are not fixed or will not be fixed.
        Availability
              - Includes where a collection has been released; either Galaxy or
                Ansible Automation Platform.

.. .............................................................................
.. External links
.. .............................................................................

.. _CVEs:
   https://www.cve.org/
