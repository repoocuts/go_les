const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
	content: [
		'./public/*.html',
		'./app/helpers/**/*.rb',
		'./app/javascript/**/*.js',
		'./app/views/**/*.{erb,haml,html,slim}'
	],
	theme: {
		container: {
			center: true,
		},
		extend: {
			fontFamily: {
				sans: ['Noto San', ...defaultTheme.fontFamily.sans],
			},
		},
		screens: {
			'phone': '340px',
			// => @media (min-width: 640px) { ... }

			'tablet': '768px',
			// => @media (min-width: 768px) { ... }

			'laptop': '1024px',
			// => @media (min-width: 1024px) { ... }

			'xl': '1280px',
			// => @media (min-width: 1280px) { ... }

			'2xl': '1536px',
			// => @media (min-width: 1536px) { ... }
		},
	},
	plugins: [
		require('@tailwindcss/forms'),
		require('@tailwindcss/aspect-ratio'),
		require('@tailwindcss/typography'),
		require('@tailwindcss/container-queries'),
	]
}
