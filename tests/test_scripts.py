import subprocess
from pathlib import Path

import pytest

TEST_NAMES = [
    str(name)[14:-3].replace("/", ".") for name in Path("tests/scripts").glob("**/test_*.sh")
]


@pytest.mark.parametrize("test_name", TEST_NAMES)
def test_script(test_name):
    run = subprocess.run([Path("tests", "scripts", test_name.replace(".", "/") + ".sh")])
    assert run.returncode == 0
