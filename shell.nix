let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs {};
in
pkgs.mkShell {
  name = "scripts-shell";
  buildInputs = with pkgs; [
    chart-testing
    ginkgo
    git
    go_1_19
    golint
    kubectl
    kubernetes-helm
    gnumake
    minikube
    semver-tool
    yq-go
  ];
  shellHook = ''
    export GOPATH=$(pwd)/nix/.go
    export TMPDIR=$(pwd)/nix/.tmp
    export PATH=$GOPATH/bin:$PATH
    go install sigs.k8s.io/controller-tools/cmd/controller-gen@v0.4.0
    mkdir -p "$TMPDIR"
  '';
}
