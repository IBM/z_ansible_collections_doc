##############################################################################
# © Copyright IBM Corporation 2020, 2021                                     #
##############################################################################

##############################################################################
#                 Sphinx documentation Configuration                         #
##############################################################################
# Configuration file for the Sphinx documentation builder, for more follow link:
# https://www.sphinx-doc.org/en/master/usage/configuration.html
# ``sphinx-build``` options follow link:
# https://www.sphinx-doc.org/en/latest/man/sphinx-build.html
##############################################################################

##############################################################################
# Project information
##############################################################################

project = 'Red Hat Ansible Certified Content for IBM Z'
copyright = 'IBM Corp. 2020, 2024'
author = 'IBM'

# Disable the Copyright footer for Read the docs at the bottom of the page
# by setting property html_show_copyright = False
html_show_copyright = True

# Disable showing Sphinx footer message:
# "Built with Sphinx using a theme provided by Read the Docs. "
html_show_sphinx = False

##############################################################################
# General configuration
##############################################################################

# Add any Sphinx extension module names here, as strings. They can be extensions
# coming with Sphinx (named 'sphinx.ext.*') or your custom ones.
extensions = [
    "sphinx_rtd_theme"
]

# Add any paths that contain templates here, relative to this directory.
# This sites template is ../templates/module.rst.j2
templates_path = ['templates']

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This pattern also affects html_static_path and html_extra_path.
exclude_patterns = exclude_patterns = [
    'ibm_zos_cics/docs/source/index.rst',
    'ibm_zos_cics/docs/source/installation.rst',
    'ibm_zos_cics/docs/source/playbooks.rst',
    'ibm_zos_cics/docs/source/requirements.rst',
    'ibm_zos_cics/docs/zos-collection-index.rst',
    'ibm_zos_core/docs/files/role_sample/roles.rst',
    'ibm_zos_core/docs/source/index.rst',
    'ibm_zos_core/docs/source/installation.rst',
    'ibm_zos_core/docs/source/license.rst',
    'ibm_zos_core/docs/source/playbooks.rst',
    'ibm_zos_core/docs/source/requirements-single.rst',
    'ibm_zos_core/docs/source/requirements.rst',
    'ibm_zos_core/docs/zos-collection-index.rst',
    'ibm_zos_ims/docs/source/index.rst',
    'ibm_zos_ims/docs/source/installation.rst',
    'ibm_zos_ims/docs/source/license.rst',
    'ibm_zos_ims/docs/source/playbook_config_setup.rst',
    'ibm_zos_ims/docs/source/playbook_group_vars.rst',
    'ibm_zos_ims/docs/source/playbook_inventory.rst',
    'ibm_zos_ims/docs/source/playbook_run.rst',
    'ibm_zos_ims/docs/source/playbooks-single.rst',
    'ibm_zos_ims/docs/source/playbooks.rst',
    'ibm_zos_ims/docs/source/requirements-single.rst',
    'ibm_zos_ims/docs/source/requirements.rst',
    'ibm_zos_sysauto/docs/source/index.rst',
    'ibm_zos_sysauto/docs/source/installation.rst',
    'ibm_zos_sysauto/docs/source/license.rst',
    'ibm_zos_sysauto/docs/source/playbooks.rst',
    'ibm_zos_sysauto/docs/source/requirements.rst',
    'ibm_zos_sysauto/docs/source/playbooks/sample_pb_create_dynres.rst',
    'ibm_zos_sysauto/docs/source/playbooks/sample_pb_delete_dynres.rst',
    'zhmc-ansible-modules/docs/source/community_guides.rst',
    'zhmc-ansible-modules/docs/source/index.rst',
    'zhmc-ansible-modules/docs/source/installation.rst',
    'zhmc-ansible-modules/docs/source/playbooks.rst',
    'zhmc-ansible-modules/docs/source/requirements.rst',
    'zhmc-ansible-modules/docs/source/versioning.rst',
    'howdoi/howdoi.rst',
    'ibm_zosmf/docs/source/index.rst',
    'ibm_zosmf/docs/source/requirements.rst',
    'ibm_zosmf/docs/source/installation.rst',
    'ibm_zosmf/docs/source/license.rst',
    'ibm_zosmf/docs/source/playbooks.rst',
    'ibm_zosmf/docs/source/requirements-single.rst',
    'ibm_zos_core/CHANGELOG.rst',
    'ibm_zos_ims/CHANGELOG.rst',
    'ibm_zos_sysauto/CHANGELOG.rst',
    'ibm_zosmf/CHANGELOG.rst',
    'ibm_zos_cics/CHANGELOG.rst'
    ]

##############################################################################
# Options for HTML output
##############################################################################

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes such 'alabaster'. Currently this site uses the
# sphinx_rtd_theme HTML theme.
html_theme = "sphinx_rtd_theme"

# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the built-in "default.css".
# html_static_path = ['_static']

# Github options used with Sphinx
html_context = {
    "display_github": "False",
    "github_user": "ansible-collections",
    "github_repo": "ibm_zos_core",
    "github_version": "main",
    "conf_py_path": "/docs/source/",
}

# Currently we are not using these options, for more info follow links:
# https://sphinx-rtd-theme.readthedocs.io/en/latest/configuring.html
# https://sphinx-rtd-theme.readthedocs.io/en/stable/
html_theme_options = {
    'prev_next_buttons_location': None
    # 'canonical_url': '',
    #'analytics_id': 'UA-XXXXXXX-1',
    #'logo_only': False,
    #'display_version': True,
    #'prev_next_buttons_location': 'bottom',
    #'style_external_links': False,
    #'vcs_pageview_mode': '',
    #'style_nav_header_background': 'white',
    #Toc options
    #'collapse_navigation': True,
    #'sticky_navigation': True,
    #'navigation_depth': 4,
    #'includehidden': True,
    #'titles_only': False
}

# Add the following function so the width of the page in display adapts to the user's screen
def setup(app):
    app.add_css_file('my_theme.css')

html_static_path = ['_static'] 



##############################################################################
#                          sphinx-versioning                                 #
##############################################################################
# Options for sphinx-versioning 1.0.0
# https://pypi.org/project/sphinx-versions/1.0.0/
#
# Documentation for v1.0.0
# https://github.com/Smile-SA/sphinx-versions/blob/v1.0.0/docs/settings.rst
#
# For more information on sphinx-versioning options follow this link:
# https://sphinx-versions.readthedocs.io/en/latest/settings.html#cmdoption-arg-destination
#
# Commands:
# sphinx-versioning -l docs/source/conf.py build docs/source/ docs/build/html
# open docs/build/html/v1.1.0-beta1/index.html
##############################################################################

# Give the underlying ``sphinx-build`` program command line options.
# ``sphinx-versions`` passes everything after ``--`` to it ``sphinx-build`` and
# in this case we are wanting to disable the sphinx footer.
# NOTE:  Appending "-- -D html_show_sphinx=False" to the Makefile
# ``sphinx-versioning`` command nor the ``scv_overflow`` are working.
### scv_overflow = ("-D", "html_show_sphinx=False")

# Choosing to not generate documentation on any branch and rely solely on
# Github tags. Branches are whitelisted with option 'scv_whitelist_branches'.
# In other words, filter out any branches that don't match the pattern.
### scv_whitelist_branches = ('release-v1.1.0-beta1',)

# Since all branches are whitelisted, a 'root_ref' must be specified to avoid
# the error: "Root ref main not found in: v1.0.0 v1.1.0-beta1". The simplest
# solution is to provide a known tagged branch to serve as the root_ref such
# as 'v1.0.0'.
# UPDATE: Able to avoid 'root_ref' by setting property 'scv_recent_tag= True'
# thus commenting out scv_root_ref = 'v1.0.0'.
# scv_root_ref = 'v1.0.0'

# Override root-ref to be the most recent committed tag. If no tags have docs
# then this option is ignored and --root-ref is used. Since we whitelist the
# main branch, we need to set a "root_ref" to avoid error
# "Root ref main not found in: v1.0.0 v1.1.0-beta1", See also 'scv_root_ref'.
# UPDATE: Able to avoid 'root_ref' by setting property 'scv_greatest_tag= True'
# thus commenting out scv_recent_tag = True'.
# scv_recent_tag = True

# Override root-ref to be the tag with the highest version number. If no tags
# have docs then this option is ignored and --root-ref is used. Since we
# whitelist the main branch, we need to set a root_ref.
# See also 'scv_root_ref
### scv_greatest_tag = True

# White list which Git tags documentation will be generated and linked into the
# version selection box. This is currently a manual selection, until more
# versions are released, there are no regular expressions used.
### scv_whitelist_tags = ('v1.0.0', 'v1.1.0-beta1')

# Sort versions by one or more values. Valid values are semver, alpha, and time.
# Semantic is referred to as 'semver', this would ensure our latest VRM is
# the first in the list of documentation links.
scv_sort = ('semver',)

# Show a warning banner. Enables the Banner Message feature. Further info:
# https://sphinx-versions.readthedocs.io/en/latest/banner.html#banner
### scv_show_banner = True

# The branch/tag considered to be the latest/current version. The banner will
# not be displayed in this ref, only in all others. Default is main.
# This can override the scv_banner_greatest_tag option, but given the greatest
# tag is currently desired behavior, this site will rely on
# 'scv_banner_greatest_tag = True' and not use 'scv_banner_main_ref'
# scv_banner_main_ref = 'v1.1.0-beta1'

# Override banner-main-ref to be the tag with the highest version number. If no
# tags have docs then this option is ignored and --banner-main-ref is used.
# The greatest tag is desirable behavior for this site.
### scv_banner_greatest_tag = True
