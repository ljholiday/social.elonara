# SEO TODO

## Goal

Maximize SEO for the public parts of the site without exposing or encouraging indexing of private, authenticated, admin, tokenized, or user-specific pages.

## Current State

- Basic page descriptions and social tags exist in `templates/partials/head-meta.php`.
- There is no `robots.txt`.
- There is no sitemap.
- There are no canonical tags.
- There is no explicit page-level `index` vs `noindex` policy.
- The route layer mixes public pages with private, authenticated, edit, manage, admin, API, and tokenized pages.

## Phase 1: Define What Can Be Indexed

### Indexable page types

- Public event detail pages: `/events/{slug}`
- Public community detail pages: `/communities/{slug}`
- Public profile pages only if the user has a public-search / search-engine-visible setting
- Public browse pages only if they are stable, useful to anonymous visitors, and not viewer-specific

### Non-indexable page types

- `/auth`
- `/login`
- `/register`
- `/reset-password`
- `/reset-password/{token}`
- `/logout`
- `/admin*`
- `/api*`
- `/profile`
- `/profile/edit`
- `/events/create`
- `/events/{slug}/edit`
- `/events/{slug}/manage`
- `/communities/create`
- `/communities/{slug}/edit`
- `/communities/{slug}/manage`
- RSVP / invitation / tokenized pages
- Any page whose visible content depends on the logged-in viewer
- Any private, invite-only, or membership-gated entity page

### Immediate policy recommendation

- Treat public event detail pages and public community detail pages as the primary SEO targets.
- Keep edit, manage, member, admin, API, token, and user-specific pages out of the index.
- Only index profiles if there is a clear product decision that public profiles should rank in search engines.

## Phase 2: Add Technical SEO Controls

### Head metadata

- Add canonical tag support to `templates/partials/head-meta.php`.
- Add support for page-level robots meta tags in `templates/partials/head-meta.php`.
- Default to `noindex,follow` or `noindex,nofollow` on non-public pages.
- Explicitly set `index,follow` only on approved public pages.

### Canonicalization

- Choose one canonical format for profiles.
- The app currently supports both numeric IDs and usernames for profiles; only one should be canonical.
- Add absolute canonical URLs for all public SEO-targeted pages.
- Normalize query-parameter pages such as:
  - `/events?filter=my`
  - `/communities?circle=inner`
- Either noindex filtered pages or canonicalize them to the default public browse page.

### Route-level crawl policy

- Add a simple way for each rendered page to pass:
  - `canonical_url`
  - `robots_meta`
- Use that policy consistently in controllers / route rendering.

## Phase 3: Add Robots.txt

Create `public/robots.txt` with:

- Sitemap reference
- Disallow rules for admin, API, auth, tokenized, and other non-public paths

Initial rules should cover:

- `Disallow: /admin`
- `Disallow: /api`
- `Disallow: /auth`
- `Disallow: /login`
- `Disallow: /register`
- `Disallow: /reset-password`
- `Disallow: /logout`

Note:

- `robots.txt` is crawl guidance, not an access-control mechanism.
- Private pages still need proper auth and `noindex` handling where appropriate.

## Phase 4: Add a Selective Sitemap

### Sitemap scope

Include only:

- Public events that can be viewed without login
- Public communities that can be viewed without login
- Public profiles only if profile indexing is a deliberate product decision

Exclude:

- Private or invite-only entities
- Logged-in-only pages
- Admin pages
- API endpoints
- Edit/manage/member pages
- Tokenized links
- Thin or low-value pages

### Sitemap structure

Preferred:

- `/sitemap.xml` as a sitemap index
- `/sitemaps/events.xml`
- `/sitemaps/communities.xml`
- `/sitemaps/profiles.xml` only if profile indexing is enabled

Each sitemap entry should include:

- Canonical URL
- `lastmod`

### Generation approach

- Generate dynamically via a route, or
- Generate static XML files as part of a deploy/admin task

Recommendation:

- Start with dynamic generation if the dataset is still modest.
- Move to generated static files if sitemap volume grows.

## Phase 5: Improve Public Page Content Quality

### Event pages

- Ensure unique `<title>` and meta description
- Render event description as crawlable HTML text
- Include clear date/time/location text
- Include organizer or host information if public
- Add internal links to related communities and public profiles where appropriate

### Community pages

- Ensure unique `<title>` and meta description
- Render a meaningful public description above the fold
- Link to upcoming public events and related public communities
- Keep member-only data out of the indexable version of the page

### Profile pages

- Only index if the profile is intentionally public
- Noindex empty or very thin profiles
- Consider requiring a minimum amount of public content before indexing

## Phase 6: Add Structured Data

Prioritize:

- `Event` schema on event detail pages
- `Person` schema on public profiles if profile indexing is enabled
- Organization/community-related schema where it accurately fits the public community model
- `BreadcrumbList` on public entity pages

Requirements:

- Structured data must match visible on-page content
- Do not emit structured data for private details not shown publicly

## Phase 7: Improve Public Entry Points

The current home route redirects logged-out visitors to `/auth`, which limits top-of-funnel SEO value.

Evaluate adding:

- A true public homepage
- A public events landing page for anonymous visitors
- A public communities landing page for anonymous visitors

The public homepage should:

- Explain the product clearly
- Link to public event and community pages
- Contain crawlable marketing copy
- Serve as the primary SEO entry point instead of `/auth`

## Phase 8: Measurement and Validation

Before launch:

- Verify public SEO pages return `200`
- Verify private / authenticated pages emit `noindex`
- Verify canonical tags are absolute and stable
- Verify sitemap contains only public URLs
- Verify no duplicate indexable URLs exist for the same entity

After launch:

- Submit the sitemap to Google Search Console
- Submit the sitemap to Bing Webmaster Tools
- Track indexed pages
- Track crawl errors
- Track duplicate URL warnings
- Track impressions and clicks for public event/community pages

## Suggested Implementation Order

1. Add page-level canonical and robots meta support.
2. Define which routes are explicitly indexable vs non-indexable.
3. Add `public/robots.txt`.
4. Add selective sitemap generation.
5. Improve titles/descriptions/content on public event and community pages.
6. Add structured data.
7. Add a true public homepage if organic growth is a priority.

## Route Audit Checklist

Review each route group and mark it:

- `index,follow`
- `noindex,follow`
- `noindex,nofollow`
- blocked from crawling in `robots.txt`

Initial assumptions:

- Event detail pages: likely `index,follow` when public
- Community detail pages: likely `index,follow` when public
- Profile pages: product decision required
- Browse/filter pages: probably `noindex,follow` unless they become strong public landing pages
- Auth/admin/API/edit/manage/token pages: `noindex`

