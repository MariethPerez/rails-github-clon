require 'faker'

Faker::Config.locale = 'es'
user_id = 1
repository_id=1
access = ["public","private"]

50.times do
  name = Faker::Name.unique.name

  user = {
    username: Faker::Internet.username(name[0..10]),
    name: name,
    birthday: Faker::Date.between(80.year.ago, 10.year.ago),
    email: Faker::Internet.safe_email(name[0..10]),
    bio: Faker::Lorem.paragraph,
    company: Faker::Company.name,
    location: Faker::Nation.nationality,
    website: Faker::Internet.domain_name 
  }
  User.create(user)

  repo_count = [1,2,3].sample
  repo_count.times do
    repository = {
      name: Faker::App.name, 
      description: "Description of repository #{repository_id}", 
      access: access.sample, 
      license: "none", 
      user_id: user_id,
    }
    Repository.create(repository)

    branch_count = [1,2,3,4,5].sample
    branch_count.times do
      branch ={
        name: Faker::App.name,
        user_id: user_id,
        repository_id: repository_id
      }
      Branch.create(branch)
    end
    repository_id += 1
  end
  user_id += 1
end