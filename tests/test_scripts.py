import subprocess
from pathlib import Path

import pytest


def pytest_generate_tests(metafunc):
    params = []
    for path in Path("tests/scripts").glob("**/test_*.sh"):
        mark = getattr(pytest.mark, path.parts[2])
        params.append(pytest.param(str(path), marks=mark))

    metafunc.parametrize("path", params)


def test_script(path):
    run = subprocess.run([path])
    assert run.returncode == 0
