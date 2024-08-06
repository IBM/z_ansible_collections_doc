.. ...........................................................................© Copyright IBM Corporation 2020, 2024                                          .
.. ...........................................................................

.. _faqs:

====
FAQs
====

Below is a list of frequently asked questions (FAQ) about Red Hat® Ansible® Certified Content for IBM Z®.

------------
Installation
------------

How do I install a collection?
##############################

You can install a collection using one of the following options:

* Ansible Galaxy : Use the ``ansible-galaxy`` command with the **install**
  option to install a collection hosted in Galaxy on your control node

* Automation Hub and Private Galaxy server: You can use the ``ansible-galaxy``
  command with the **install** option to install a collection on your
  control node hosted in Automation Hub or a private Galaxy server.
  You need to configure the ``auth_url`` option and the API ``token``  in
  **ansible.cfg** for each server name.

* Local installation: You can use the ``ansible-galaxy`` collection install
  command to install a collection built from source. To build your own
  collection, you must clone the Git repository, build the collection archive,
  and install the collection.

For detailed instructions on how to install a collection, see the :ref:`installation` doc.


