# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-component.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-mesh.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-model.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-operation.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-react.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-router.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-spec.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyper-store.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyperloop.git', default_branch: '1_0_0')
Project.create(github_host: 'github.com', repo: 'ruby-hyperloop/hyperloop-config.git', default_branch: '1_0_0')
