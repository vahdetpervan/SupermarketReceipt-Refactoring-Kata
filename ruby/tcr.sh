#!/bin/bash

# This is a simple TCR setup for a Ruby-based project with
# RSpec.

(bundle exec rake test && git commit -am "WIP") || git checkout .
