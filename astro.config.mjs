// @ts-check
import fs from "fs";

import { defineConfig } from "astro/config";

import sitemap from "@astrojs/sitemap";

// https://astro.build/config
export default defineConfig({
  site: "https://heinrichtaver.com",

  image: {
    layout: "constrained",
    responsiveStyles: true,
  },

  integrations: [sitemap({
    serialize(item) {
      switch (new URL(item.url).pathname) {
      case "/":
        item.lastmod = fs.statSync("./src/pages/index.md").mtime.toISOString();
        break;
      case "/now/":
        item.lastmod = fs.statSync("./src/pages/now.md").mtime.toISOString();
        break;
      case "/blog/":
        item.lastmod = fs.statSync("./src/pages/blog.astro").mtime.toISOString();
        break;
      default:
        const page = `./src/pages${new URL(item.url).pathname}`;

        if (/\/blog\/.*/.test(page)) {
          item.lastmod = fs.statSync(`${page.slice(0,-1)}.md`).mtime.toISOString();
        }
      }

      return item;
    }
  })]
});
