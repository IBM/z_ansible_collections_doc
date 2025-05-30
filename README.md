<h2 align="left" style="width:75%;">Red Hat Ansible Certified Content for IBM Z Documentation Repository</h2>
<h4 align="left"  style="width:75%;">

This repository is used to extract, build, generate and publish the documentation for
Red Hat Ansible Certified Content for IBM Z. The content in the repository is available
so that collections can validate the their documentation.<br>

To build the documentation, you must have the correct dependencies which are provided
either by using a pre-built container, containerfile, Python virtual environment or
the requirements.txt. <br>

The table of contents outlines the process in chronological order ending in how to
build the documentation.
</h4>

<!-- META  &  Breadcrumbs -->
<a id="readme-top"></a>
▸ [Table of Contents](README.md)

<ul>
  <li>
    <details open><summary><a href="./toc/container_usage/README.md#setup-a-container-for-generating-documentation">Setup a container for generating documentation</a></summary></details>
  </li>
  <ul>
    <li>
      <details><summary><a href="./toc/container_usage/README.md#10-podman-desktop">1.0 - Podman Desktop</a></summary>
      <ul>
        <li><a href="./toc/container_usage/README.md#11---download-podman-desktop">1.1 - Download Podman Desktop</a></li>
        <li><a href="./toc/container_usage/README.md#12---install-podman-desktop">1.2 - Install Podman Desktop</a></li>
      </ul>
      </details>
    </li>
    <li>
      <details><summary><a href="./toc/container/README.md#20-podman-image">2.0 - Podman Image</a></summary>
      <ul>
        <li><a href="./toc/container_usage/README.md#21---build-the-image-using-the-containerfile">2.1 - Build the image using a Containerfile</a></li>
        <li><a href="./toc/container_usage/README.md#22---obtain-the-prebuilt-image">2.2 - Obtain the prebuilt image</a></li>
        <li><a href="./toc/container_usage/README.md#23---load-the-prebuilt-image">2.3 - Load the prebuilt imagee</a></li>
      </ul>
      </details>
    </li>
    <li>
      <details><summary><a href="./toc/container_usage/README.md#30-podman-container">3.0 - Podman Container</a></summary>
      <ul>
        <li><a href="./toc/container_usage/README.md#31---start-the-container-in-detached-mode">3.1 - Start the container in detached mode</a></li>
        <li><a href="./toc/container_usage/README.md#32---connect-interactively-to-a-container">3.2 - Connect interactively to a container</a></li>
        <li><a href="./toc/container_usage/README.md#33---other-commands-to-aid-in-managing-the-container">3.2 - Other commands to aid in managing the container</a></li>
      </ul>
      </details>
    </li>
    <li>
      <details>
        <summary>
          <a href="./toc/container_usage/README.md#40-add-the-ssh-key-to-your-github-account">4.0 - Add the containers SSH key to your GitHub account</a>
        </summary>
      <ul>
        <li>
          <a href="./toc/container_usage/README.md#41---copy-the-ssh-public-key">4.1 - Copy the SSH public key </a>
        </li>
        <li>
          <a href="./toc/container_usage/README.md#42---add-the-ssh-public-key-to-github">4.2 - Add the SSH public key to GitHub</a>
        </li>
      </ul>
      </details>
    </li>
  </ul>
</ul>

<ul>
  <li>
    <details open><summary><a href="./toc/venv_usage/README.md#setup-a-python-virtual-environment-for-generating-documentation">Setup a Python virtual environment for generating documentation</a></summary>
    <ul>
      <li><a href="./toc/venv_usage/README.md#10-clone-the-repository">1.0 - Clone the repository </a></li>
      <li><a href="./toc/venv_usage/README.md#20-setup-the-python-virtual-environment">2.0 - Setup the Python Virtual Environment</a></li>
      <li><a href="./toc/venv_usage/README.md#21-requirements">2.1 - Requirements</a></li>
      <li><a href="./toc/venv_usage/README.md#22-configuration">2.2 - Configuration</a></li>
      <li><a href="./toc/venv_usage/README.md#23-build-the-python-virtual-environment">2.3 - Build the Python virtual environment</a></li>
      <li><a href="./toc/venv_usage/README.md#24-validate-the-python-virtual-environment">2.4 - Validate the Python virtual environment</a></li>
    </ul>
    </details>
  </li>
</ul>

<ul>
  <li>
    <details open>
      <summary>
        <a href="./toc/doc_generation/README.md#documentation-for-red-hat-certified-content-for-ibm-z">Documentation for Red Hat Certified Content for IBM Z</a>
      </summary>
      <ul>
        <li><a href="./toc/doc_generation/README.md#10-clone-the-repository">1.0 - Clone the repository</a></li>
        <li><a href="./toc/doc_generation/README.md#20-update-the-registry">2.0 - Update the registry</a></li>
        <li><a href="./toc/doc_generation/README.md#30-the-ansible-playbooks">3.0 - The Ansible playbooks</a></li>
        <li><a href="./toc/doc_generation/README.md#40-run-the-ansible-playbooks">4.0 - Run the Ansible playbooks</a></li>
      </ul>
      </details>
    </li>
</ul>

<p align="right">[<a href="#readme-top">Top</a>]</p>