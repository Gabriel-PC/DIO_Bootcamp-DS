
from setuptools import setup, find_packages

with open("readme.md", "r") as f:
    page_description = f.read()

with open("requirements.txt") as f:
    requirements = f.read().splitlines()

setup(
    name="pacote-teste",
    version="0.0.1",
    author="Gabriel-PC",
    author_email="my_email",
    description="Teste para criação de pacotes",
    long_description=page_description,
    long_description_content_type="text/markdown",
    url="https://github.com/Gabriel-PC/DIO_Bootcamp-DS/tree/main/cria%C3%A7%C3%A3o-de-pacotes"
    packages=find_packages(),
    install_requires=requirements,
    python_requires='>=3.8',
)
