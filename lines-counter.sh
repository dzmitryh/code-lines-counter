#!/bin/bash

set -e

project_repos=jib,jdk9-playground
project_dir=/projects/Pet-Projects
total_lines_count=0
total_project_repos=10


IFS=',' read -r -a project_repos <<< "$project_repos"
repos_count=${#project_repos[@]}
echo "Repos count is $repos_count"

for repo in "${project_repos[@]}"; do
    repo_dir=$project_dir/$repo

    cd $repo_dir
    repo_lines_count=$(eval git ls-files | xargs cat | wc -l)
    echo "lines count in $repo_dir is $repo_lines_count"
    total_lines_count=$((total_lines_count+repo_lines_count))
done

echo "Total lines in $repos_count repos is $total_lines_count"

average_lines_per_repo=$((total_lines_count/repos_count))
echo "Average lines count per repo is $average_lines_per_repo"

approximate_total_lines_count_in_project=$((average_lines_per_repo*total_project_repos))
echo "Approximatly total lines count in project is $approximate_total_lines_count_in_project"
