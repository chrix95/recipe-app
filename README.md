# Recipe Guide

A Ruby on Rails application for browsing various food recipes.

## Prerequisites

Ensure you have the following installed on your machine:

- Ruby (version 3.3.0)
```
ruby -v
```
- Rails (version 7.1.2)
```
rails -v
```
- No database was used, so no need to setup any

## Getting Started

1. **Clone the Repository:**
```
git clone https://github.com/chrix95/recipe-app.git
```
2. **Navigate to the Project Directory:**
```
cd recipe-app
```
3. **Install Dependencies:**
```
bundle install
```
4. **Start the Rails Server:**
```
rails server
```
5. **To run the test suite:**
```
bundle exec rspec
```

The application will be accessible at http://localhost:3000.

## Usage

**Main Entry:**
- Access the entry API url at [http://localhost:3000](http://localhost:3000) which returns the current API version.

**Categories:**
- View all recipe categories at [http://localhost:3000/categories](http://localhost:3000/categories).

**Filter Recipes by Category:**
- To filter recipes by a specific category, replace `:category` in the URL at [http://localhost:3000/recipes/:category](http://localhost:3000/recipes/:category) with the desired category name.<br>
Example: [http://localhost:3000/recipes/beef](http://localhost:3000/recipes/beef).

**Lookup Recipe by ID:**
- To look up a recipe by ID, replace `:id` in the URL at [http://localhost:3000/recipe/:id](http://localhost:3000/recipe/:id) with the desired recipe ID <br>
Example: [http://localhost:3000/recipe/53054](http://localhost:3000/recipe/53054).

## Contributing

If you would like to contribute to the project:

1. Fork the repository.
2. Create a new branch for your feature or bug fix: `git checkout -b feature-name`.
3. Make changes and commit them: `git commit -m 'Description of changes'`.
4. Push to the branch: `git push origin feature-name`.
5. Open a pull request.

## Contributor
- Email: [engchris95@gmail.com](mailto:engchris95@gmail.com)
- Github: [https://github.com/chrix95](https://github.com/chrix95)