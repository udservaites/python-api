from pathlib import Path

from setuptools import setup


if __name__ == '__main__':
    tests_require = [
        'pytest',
        'flake8',
        'mypy',
        'pylint',
        'pytest-cov',
    ]

    docs_require = [
        'mkdocs',
        'mkdocs-macros-plugin',
        'mkdocs-mermaid-plugin',
        'inari[mkdocs]',
        'pymdown-extensions',
    ]

    setup(
        name="python-api",
        author="Darth vader",
        author_email="vader@gmail.com",
        description="Test python project",

        long_description=Path("README.md").read_text(),
        long_description_content_type="text/markdown",

        url="https://git.act3-ace.ai/neuroscience-research/programming-practice/python-api",

        license="Distribution C",

        setup_requires=[
            'setuptools_scm',
            'pytest-runner'
        ],
        use_scm_version={
            'fallback_version': '0.0.0',
        },

        # add in package_data
        include_package_data=True,
        package_data={
            'python_api': ['*.yml', '*.yaml']
        },

        packages=[
                'python_api',
        ],
        package_dir={'': '.'},

        classifiers=[
            "Programming Language :: Python :: 3",
            "License :: OSI Approved :: MIT License",
            "Operating System :: OS Independent",
        ],

        install_requires=[
            'numpy', 
            'build',
            'fastapi',
            'httpx',
            'uvicorn'
        ],
        extras_require={
            "testing":  tests_require,
            "docs":  docs_require,
        },
        python_requires='>=3.7',

        entry_points={
            'console_scripts': [

            ],
        },

    )
