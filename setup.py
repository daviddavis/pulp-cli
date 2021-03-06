from setuptools import find_namespace_packages, setup

packages = find_namespace_packages(include=["pulpcore.cli.*"])


setup(
    name="pulp-cli",
    description="Command line interface to talk to pulpcore's REST API.",
    version="0.2.1.dev",
    packages=packages,
    package_data={package: ["py.typed"] for package in packages},
    python_requires=">=3.6",
    install_requires=[
        "click",
        "packaging",
        "PyYAML",
        "requests",
        "toml",
    ],
    extras_require={
        "pygments": ["pygments"],
    },
    entry_points={
        "console_scripts": "pulp=pulpcore.cli.common:main",
        "pulp_cli.plugins": [
            "ansible=pulpcore.cli.ansible",
            "container=pulpcore.cli.container",
            "core=pulpcore.cli.core",
            "file=pulpcore.cli.file",
            "rpm=pulpcore.cli.rpm",
        ],
    },
    license="GPLv2+",
    classifiers=[
        "Development Status :: 3 - Alpha",
        "Environment :: Console",
        "Intended Audience :: System Administrators",
        "License :: OSI Approved :: GNU General Public License v2 or later (GPLv2+)",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3",
        "Topic :: System :: Software Distribution",
        "Typing :: Typed",
    ],
)
