require 'faker'
Faker::Config.locale = 'es'

user_id = 1
repository_id = 1
branch_id = 1

#Create 50 users
50.times do
  name = Faker::Name.unique.name

  user = {
    username: Faker::Internet.username(name[0..10]),
    name: name,
    birthday: Faker::Date.between(80.year.ago, 10.year.ago),
    email: Faker::Internet.safe_email(name[0..10]),
    bio: "This is the Bio of #{name}",
    company: Faker::Company.name,
    location: Faker::Nation.nationality,
    website: Faker::Internet.domain_name 
  }
  User.create(user)

  #For each user creates in between 1 to 3 repositories
  repo_count = [1,2,3].sample
  repo_count.times do
    repository = {
      name: Faker::App.name, 
      description: "Description of repository #{repository_id}", 
      access: ["public","private"].sample, 
      license: "none", 
      user_id: user_id,
    }
    Repository.create(repository)

    #For each repository creates in between 1 to 5 branches
    branch_count = [1,2,3,4,5].sample
    branch_count.times do
      branch ={
        name: Faker::App.name,
        user_id: user_id,
        repository_id: repository_id
      }
      Branch.create(branch)
      branch_id += 1
    end
    repository_id += 1
  end
  user_id += 1
end

# Creates 100 random issues
issue_id = 1
100.times do
  issue ={
    title: "Tittle of Issue #{issue_id}",
    description: "Description of Issue #{issue_id}",
    label: ["none", "bug", "enhancement"].sample,
    user_create_id: rand(1..(user_id-1)),
    user_assign_id: rand(1..(user_id-1)),
    repository_id: rand(1..(repository_id-1))
  }
  Issue.create(issue)
  issue_id += 1
end

# Creates 1000 random pull requests
pull_request_id = 1
1000.times do
  pull_request ={
    title: "Tittle of Pull Request #{pull_request_id}",
    status: ["true", "false"].sample,
    description: "Description of Issue #{pull_request_id}",
    branch_in_id: rand(1..(branch_id-1)),
    branch_out_id: rand(1..(branch_id-1)),
  }
  PullRequest.create(pull_request)
  pull_request_id += 1
end
