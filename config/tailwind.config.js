const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
	content: [
		'./public/*.html',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/views/**/*.{erb,haml,html,slim}',
		'./app/components/**/*.{erb,html}'
	],
	theme: {
		container: {
			center: true,
		},
		extend: {
			fontFamily: {
				display: ['"Noto Sans Display"', 'sans'],
				sans: ['Anaheim', 'sans'],
			},
		},
		screens: {
			'phone': '340px',
			'tablet': '768px',
			'laptop': '1024px',
			'xl': '1280px',
			'2xl': '1536px',
		},
	},
	plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/aspect-ratio'),
		require('@tailwindcss/typography'),
		require('@tailwindcss/container-queries'),
	]
}
