.. ...........................................................................
.. © Copyright IBM Corporation 2020, 2026                                    .
.. ...........................................................................

.. _collection-life-cycles-eda:

======================
Collection life cycles
======================

The Event-Driven Ansible for IBM Z (ibm_eda_zos) collection is developed and released on a flexible release cycle, as a validated content collection.

Content update
--------------

The new content and features are added as they become available and pass validation requirements. 
The team actively monitor dependencies of our use cases, and changes to these dependencies may cause certain versions of the collection to reach end of life.

End of Life (EOL) for this collection is generally a 2-year cycle unless a dependency reaches EOL prior to the 2 years. For example, if a collection has released and its dependency reaches EOL 1 year later, 
then the collection will EOL at the same time as the dependency, 1 year later.


Product life cycle
------------------

Refer to this matrix for the status of the Event-Driven Ansible collection version,
its critical dates, and the type of support it is currently eligible for.

+------------+----------------+-----------------------+------------------+-------------------+
| Version    | Status         | Changelogs            | GA Date          | EOL Date          | 
+============+================+=======================+==================+===================+
| 1.0.x      | Released       | `1.0.x changelogs`_   | June 2026        | October 2028      |     
+------------+----------------+-----------------------+------------------+-------------------+

.. .............................................................................
.. Global Links
.. .............................................................................
.. _1.0.x changelogs:
    https://github.com/ansible-collections/ibm_eda_zos/blob/staging-v1.0/CHANGELOG.rst