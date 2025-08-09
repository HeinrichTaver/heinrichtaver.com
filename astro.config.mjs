// @ts-check
import { defineConfig } from 'astro/config';

// https://astro.build/config
export default defineConfig({
  site: "https://heinrichtaver.com",
  image: {
    layout: "constrained",
    responsiveStyles: true,
  }
});
