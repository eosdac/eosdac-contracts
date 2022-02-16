module.exports = {
  root: true,
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint'],
  extends: ['eslint:recommended', 'plugin:@typescript-eslint/recommended'],
  parserOptions: {
    project: ['./tsconfig.json'], // Specify it only for TypeScript files
  },
  rules: {
    '@typescript-eslint/no-explicit-any': 'off',
    'prefer-const': 'warn',
    '@typescript-eslint/no-floating-promises': 'error',
  },
};
