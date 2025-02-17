{ lib
, buildPythonPackage
, fetchFromGitHub
, poetry-core
, pytest-asyncio
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "aiohappyeyeballs";
  version = "2.3.2";
  pyproject = true;

  disabled = pythonOlder "3.10";

  src = fetchFromGitHub {
    owner = "bdraco";
    repo = "aiohappyeyeballs";
    rev = "refs/tags/v${version}";
    hash = "sha256-3Lj1eUDPoVCElrxowBhhrS0GCjD5qeUCiSB/gHoqC3Q=";
  };

  postPatch = ''
    substituteInPlace pyproject.toml \
      --replace " --cov=aiohappyeyeballs --cov-report=term-missing:skip-covered" ""
  '';

  nativeBuildInputs = [
    poetry-core
  ];

  nativeCheckInputs = [
    pytest-asyncio
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "aiohappyeyeballs"
  ];

  disabledTestPaths = [
    # Test has typos
    "tests/test_impl.py"
  ];

  meta = with lib; {
    description = "Modul for connecting with Happy Eyeballs";
    homepage = "https://github.com/bdraco/aiohappyeyeballs";
    changelog = "https://github.com/bdraco/aiohappyeyeballs/blob/v${version}/CHANGELOG.md";
    license = licenses.psfl;
    maintainers = with maintainers; [ fab ];
  };
}
