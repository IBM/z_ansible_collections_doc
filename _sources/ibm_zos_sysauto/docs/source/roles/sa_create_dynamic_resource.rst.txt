
.. _sa_create_dynamic_resource_role:


sa_create_dynamic_resource -- Role creates and resumes a dynamic resource
=========================================================================



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The **IBM Z System Automation collection** provides an Ansible role, referred to as **sa_create_dynamic_resource**, to create and resume a new `dynamic resource <https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/UserGuide/Dynamic_Resources.html#concept_kmr_r4p_4jb>`_ instance from a template.








Parameters
----------



sa_service_hostname
  Specifies the IBM Z System Automation Operations REST server host name.


  | **required**: True
  | **type**: str



sa_service_port
  Specifies the port to which the IBM Z Automation Operations REST service is bound.


  | **required**: True
  | **type**: str



sa_service_protocol
  Specifies the protocol that is configured for the IBM Z Automation Operations REST server.


  | **required**: True
  | **type**: str
  | **default**: HTTPS



sa_rest_api_timeout
  Specifies the socket level timeout for the REST API call in seconds.


  | **required**: False
  | **type**: int
  | **default**: 30



username
  Specifies the NetView user.


  | **required**: True
  | **type**: str



password
  Specifies the password for above user.


  | **required**: True
  | **type**: str



templateName
  Specifies the name of the template that will be used to create the dynamic resource.


  | **required**: True
  | **type**: str



subsystem
  Specifies the subsystem name of the new resource.

  The maximum length for this value is 11.


  | **required**: True
  | **type**: str



system
  Specifies the system where the resource will be created.

  The maximum length for this value is 8.


  | **required**: True
  | **type**: str



job
  Specifies the job name of the new resource.

  The maximum length for this value is 8.


  | **required**: True
  | **type**: str



procedure
  Specifies the procedure name used by the new resource.

  The maximum length for this value is 8.


  | **required**: False
  | **type**: str



comment
  Specifies a comment to be associated with the creation of the new resource.

  The maximum length for this value is 40.


  | **required**: False
  | **type**: str



group
  Specifies the automation name of the application group (APG) that will host the new resource.

  The maximum length for this value is 11.


  | **required**: False
  | **type**: str



sdesc
  Specifies a short description of the new resource.

  The maximum length for this value is 40.


  | **required**: False
  | **type**: str

path
  Specifies the fulll qualified ZFS path to find the application to be started by this new resource.

  The maximum length for this value is 159.


  | **required**: False
  | **type**: str

filter:
    Specifies an additional filter criteria to uniquely identify the USS process represented by this new resource.

    The maximum length for this value is 159.


  | **required**: False
  | **type**: str




Examples
--------

.. code-block:: yaml+jinja


   - name: create and resume a dynamic resource in SA
     hosts: sampleHost
     gather_facts: no
     collections:
       - ibm.ibm_zos_sysauto
     vars_files:
       - vars.yaml
     vars_prompt:
       - name: username
         prompt: "Enter your username"
         private: no
       - name: password
         prompt: "Enter your password"
         private: yes
     tasks:
       - include_role:
           name: sa_create_dynamic_resource




Notes
-----

.. note::
   The given example assumes that you have an inventory file *hosts* and host vars *sampleHost.yaml* with appropriate values to identify the target IBM Z System Automation Operations REST server end points.

   Also a *vars.yaml* which stores the required values for the dynamic resource that you want to create is required.






