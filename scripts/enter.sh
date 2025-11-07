#!/usr/bin/env bash
set -e

# Nixの実験的機能を有効にしてからdevelopを実行
export NIX_CONFIG="experimental-features = nix-command flakes"
nix develop --impure --command zsh

