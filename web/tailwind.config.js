/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx}",
  ],
  theme: {
    extend: {
      colors: {
        concentration: '#FF9500',
        extermination: '#FF3B30',
        labor: '#FFA500',
        transit: '#FFCC00',
      }
    },
  },
  plugins: [],
}
