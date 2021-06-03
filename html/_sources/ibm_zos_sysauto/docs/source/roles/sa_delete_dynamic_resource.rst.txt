
.. _sa_delete_dynamic_resource_role:


sa_delete_dynamic_resource -- Role deletes a dynamic resource
=============================================================



.. contents::
   :local:
   :depth: 1


Synopsis
--------
- The **IBM Z System Automation collection** provides an Ansible role, referred to as **sa_delete_dynamic_resource**, to delete a `dynamic resource <https://www.ibm.com/support/knowledgecenter/de/SSWRCJ_4.2.0/com.ibm.safos.doc_4.2/UserGuide/Dynamic_Resources.html#concept_kmr_r4p_4jb>`_ instance.








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


     
subsystem
  Specifies the exact name (subsystem name) of the resource.

  The maximum length for this value is 11.


  | **required**: True
  | **type**: str


     
system
  Specifies the system for the resource.

  The maximum length for this value is 8.


  | **required**: True
  | **type**: str




Examples
--------

.. code-block:: yaml+jinja

   
   - name: delete an SA resource
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
           name: sa_delete_dynamic_resource




Notes
-----

.. note::
   The given example assumes that you have an inventory file *hosts* and host vars *sampleHost.yaml* with appropriate values to identify the target IBM Z System Automation Operations REST server end points.

   Also a *vars.yaml* which stores the required values for the dynamic resource that you want to delete is required.






