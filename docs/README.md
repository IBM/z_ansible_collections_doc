
<h2 align="center">Container Instructions</h2>
  <p align="left"  style="width:90%;">
The container option is available for the documentation for Red Hat Certified Content for IBM Z.
There a number of reasons to use the container over the Python virtual environment:<br>
- Your system does not meet the system decencies.<br>
- Python wheel builds are not available for your system.<br>
- You prefer to work from a pre-configured container.

This container is built on the [Red Hat Universal Base Image 9 Minimal](https://catalog.redhat.com/software/containers/ubi9/ubi-minimal/615bd9b4075b022acc111bf5). The Universal Base Image Minimal is a stripped down image that uses `microdnf` as a package manager.
  </p>
</div>

---

<!-- META  &  Breadcrumbs -->
<a id="readme-top"></a>
▸ [Home](README.md)

<summary>Table of Contents</summary>
<ol>
  <li>
    <details><summary><a href="01/README.md">01 - Podman Desktop</a></summary>
      <ul>
        <li><a href="01/README.md#11---download-podman-desktop">1.1 - Download Podman Desktop</a></li>
        <li><a href="01/README.md#12---install-podman-desktop">1.2 - Install Podman Desktop</a></li>
      </ul>
    </details>
  </li>
  <li><details><summary><a href="02/README.md">02 - Podman Image</a></summary>
    <ul>
      <li><a href="02/README.md#21---build-the-image-using-the-containerfile">2.1 - Build the image using a Containerfile</a></li>
      <li><a href="02/README.md#22---obtain-the-prebuilt-image">2.2 - Obtain the prebuilt image</a></li>
      <li><a href="02/README.md#23---load-the-prebuilt-image">2.3 - Load the prebuilt imagee</a></li>
    </ul>
    </details>
  </li>
  <li>
    <details><summary><a href="03/README.md">03 - Podman Container</a></summary>
    <ul>
      <li><a href="03/README.md#31---start-the-container-in-detached-mode">3.1 - Start the container in detached mode</a></li>
      <li><a href="03/README.md#32---connect-interactively-to-a-container">3.2 - Connect interactively to a container</a></li>
      <li><a href="03/README.md#33---other-commands-to-aid-in-managing-the-container">3.2 - Other commands to aid in managing the container</a></li>
    </ul>
    </details>
  </li>
  <li>
    <details><summary><a href="04/README.md">04 - Add the containers SSH key to your GitHub account</a></summary>
    <ul>
      <li><a href="04/README.md#41---copy-the-ssh-public-key">4.1 - Copy the SSH public key </a></li>
      <li><a href="04/README.md#42---add-the-ssh-public-key-to-github">4.2 - Add the SSH public key to GitHub</a></li>
    </ul>
    </details>
  </li>
</ol>

<p align="right">[<a href="#readme-top">Top</a>]</p>