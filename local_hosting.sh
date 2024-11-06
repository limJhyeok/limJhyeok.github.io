#!/bin/bash

# _site/minimal-mistakes-jekyll.gemspec 파일이 존재하는지 확인
if [ -f "_site/minimal-mistakes-jekyll.gemspec" ]; then
  echo "Removing _site/minimal-mistakes-jekyll.gemspec file..."
  rm "_site/minimal-mistakes-jekyll.gemspec"
fi

# Jekyll 서버 실행
echo "Starting Jekyll server..."
bundle exec jekyll serve
