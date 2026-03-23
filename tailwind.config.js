/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'class',
  content: [
    './app/**/*.{js,ts,jsx,tsx,mdx}',
    './components/**/*.{js,ts,jsx,tsx,mdx}',
  ],
  theme: {
    extend: {
      colors: {
        aiox: {
          50: '#f8fafc',
          100: '#f1f5f9',
          500: '#0f172a',
          600: '#0a0f1d',
          700: '#000000',
          purple: '#7c3aed',
          accent: '#06b6d4',
        },
      },
      typography: {
        DEFAULT: {
          css: {
            color: '#1f2937',
            a: {
              color: '#7c3aed',
              '&:hover': {
                color: '#6d28d9',
              },
            },
            code: {
              color: '#dc2626',
              backgroundColor: '#f9fafb',
              paddingLeft: '4px',
              paddingRight: '4px',
              borderRadius: '4px',
            },
            pre: {
              backgroundColor: '#1f2937',
              color: '#f9fafb',
            },
          },
        },
      },
    },
  },
  plugins: [require('@tailwindcss/typography')],
};
