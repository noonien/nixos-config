#!/usr/bin/env nix-shell
#!nix-shell -i bash -p curl -p jq -p subversion -p nix-prefetch-svn
set -e
echo "not done yet"
exit 1

owner="ryanoasis"
repo="nerd-fonts"
base_url="https://github.com/$owner/$repo"

ref=master
if [ $# -ge 1 ]; then
    ref=$1
fi

#tmp=$(mktemp -d)
tmp="$HOME/tmp/nff"
#mkdir -p "$tmp"
#trap "rm -rf $tmp" EXIT

echo "resolving ref $ref"
escaped_ref=$(sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< $ref)
read git_hash git_ref < <(
    git ls-remote "${base_url}.git" | sort -t/ -k2 |
        grep -E "\brefs/(heads|tags)/$escaped_ref\$"
)
[ -z "$git_hash" ] && {
    echo "coult not find ref" 2>&1
    exit 1
}

echo "git ref: $git_ref hash: $git_hash"

svn_base="$base_url"
if [[ $git_ref == refs/heads/* ]]; then
    svn_base+="/branches/$ref"
elif [[ $git_ref == refs/tags/* ]]; then
    svn_base+="/tags/$ref"
else
    echo "invalid git ref $git_ref" 2>&1
    exit 1
fi

svn_rev=$(svn info --show-item last-changed-revision "$svn_base")
git_hash_for_svn_rev=$(svn propget git-commit --revprop -r $svn_rev "$svn_base")
[ "$git_hash" != "$git_hash_for_svn_rev" ] && {
    echo "$git_hash"
    echo "$git_hash_for_svn_rev"
    echo "could not get a svn revision number that matches the git ref" 2>&1
    exit 1
}
echo "svn revision $svn_rev"

echo "downloading and computing hashes for font-patcher and unpatched-fonts"
mkdir -p "$tmp/nerdfonts-patcher/src"
#curl "$base_url/raw/$git_hash/font_patcher" --output "$mp/nerdfonts-patcher/font-patcher"
#svn export -r $svn_rev "$svn_base/bin" "$tmp/bin/"
#svn export -r $svn_rev "$svn_base/src" "$tmp/src/"

mv "$tmp/font-patcher" "$tmp/nerdfonts-patcher"
mv "$tmp/src/glyphs" "$tmp/nerdfonts-patcher/src"

cat << EOF > "$tmp/srcs.nix"
# Code generated by \`$0 $ref\` DO NOT EDIT.
# generated at $(date)
{ pkgs, lib }:

let
  fetchGitHubFiles = pkgs.callPackage ../build-support/fetchgithubfiles {};
  repo = {
    owner = "$owner";
    repo = "$repo";
    rev = "$git_hash";
  };
  fontSrc = name: sha256: {
      inherit name;
      src = fetchGitHubFiles {
        name = "nerdfonts-\${lib.toLower name}-src";
        inherit (repo) owner repo rev;
        paths = [ "src/unpatched-fonts/\${name}" ] ++ (
            if name != "Hack" then []
            else [ "bin/scripts/Hack" ]
        );
        inherit sha256;
      };
    };
in
{
  font-patcher = fetchGitHubFiles {
    name = "nerdfonts-patcher-\${repo.rev}-src";
    inherit (repo) owner repo rev;
    paths = [
      "font-patcher"
      "src/glyphs"
    ];
    sha256 = "$(nix-hash --type sha256 --base32 "$tmp/nerdfonts-patcher")";
  };

  fonts = [
EOF


for dir in "$tmp/src/unpatched-fonts/"*/; do
    name=$(basename $dir)
    mkdir -p "$tmp/fonts/$name/src/unpatched-fonts"
    mv "$dir" "$tmp/fonts/$name/src/unpatched-fonts"

    # the font's name is Hack, of course it needs an ugly hack to build
    if [ "$name" == "Hack" ]; then
        mkdir -p "$tmp/fonts/$name/bin/scripts"
        mv "$tmp/bin/scripts/$name" "$tmp/fonts/$name/bin/scripts"
    fi

cat << EOF >> "$tmp/srcs.nix"
    (fontSrc "$name" "$(nix-hash --type sha256 --base32 "$tmp/fonts/$name")")
EOF
done

cat << EOF >> "$tmp/srcs.nix"
  ];
}
EOF

cp "$tmp/srcs.nix" .
echo "srcs.nix updated"