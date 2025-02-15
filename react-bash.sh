#!/bin/bash

# Define the project name
PROJECT_NAME=$1

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

pnpm create vite@$latest $PROJECT_NAME --template react-ts

# Navigate into the project directory
cd $PROJECT_NAME

# Install dependencies
pnpm install

# Install Tailwind CSS and its peer dependencies
pnpm install -D tailwindcss@3 postcss autoprefixer

# Initialize Tailwind CSS
npx tailwindcss init -p

# Configure Tailwind to remove unused styles in production
echo "module.exports = {
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {},
  },
  plugins: [],
}" > tailwind.config.js

# Add Tailwind CSS to your CSS file
echo "@tailwind base;
@tailwind components;
@tailwind utilities;" > ./src/index.css

# Initialize a new Git repository
git init
git add .
git commit -m "Initial commit"

echo "Project setup complete! Navigate to the $PROJECT_NAME directory and start the development server with 'npm run dev'."

# Instructions for the user to start the development server
echo "To start the development server, run the following command:"
echo "cd $PROJECT_NAME && npm run dev"

