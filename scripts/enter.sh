#!/usr/bin/env bash
set -e

# Nixの実験的機能を有効にしてからdevelopを実行
# 開発シェルに入るだけ。実験機能はflakeのnixConfigで定義済み。
nix develop --command zsh

