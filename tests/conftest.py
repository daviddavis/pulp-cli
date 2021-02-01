
def pytest_configure(config):
    config.addinivalue_line("markers", "pulpcore: pulpcore tests.")
    config.addinivalue_line("markers", "pulp_file: pulp_file tests.")
    config.addinivalue_line("markers", "pulp_ansible: pulp_ansible tests.")
    config.addinivalue_line("markers", "pulp_container: pulp_container tests.")
