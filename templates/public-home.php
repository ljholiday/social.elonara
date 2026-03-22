<?php
/** @var array<int,array<string,mixed>> $featured_events */
/** @var array<int,array<string,mixed>> $featured_communities */

$featured_events = $featured_events ?? [];
$featured_communities = $featured_communities ?? [];
?>

<section class="app-section app-mb-4">
  <div class="app-card">
    <div class="app-card-body">
      <p class="app-text-muted app-mb-2">Public on Elonara</p>
      <h2 class="app-heading app-heading-lg app-mb-4">Find communities, plan gatherings, and keep the conversation going.</h2>
      <p class="app-text-muted app-mb-4">
        Elonara helps groups organize real-world events and build trusted communities around shared interests.
        Browse public spaces first, then sign in when you are ready to participate.
      </p>
      <div class="app-flex app-flex-wrap">
        <a class="app-btn app-btn-primary" href="/events">Browse Events</a>
        <a class="app-btn" href="/communities">Browse Communities</a>
        <a class="app-btn" href="/auth">Sign In or Register</a>
      </div>
    </div>
  </div>
</section>

<section class="app-section app-mb-4">
  <div class="app-flex app-flex-between app-mb-4">
    <div>
      <h2 class="app-heading app-heading-md">Upcoming Public Events</h2>
      <p class="app-text-muted">Fresh events that can be viewed without logging in.</p>
    </div>
    <a class="app-btn app-btn-sm" href="/events">All Events</a>
  </div>

  <?php if ($featured_events !== []): ?>
    <div class="app-grid">
      <?php foreach ($featured_events as $row):
        $entity = (object)[
          'id' => (int)($row['id'] ?? 0),
          'title' => (string)($row['title'] ?? ''),
          'slug' => (string)($row['slug'] ?? ''),
          'event_date' => $row['event_date'] ?? null,
          'end_date' => $row['end_date'] ?? null,
          'description' => $row['description'] ?? '',
          'venue_info' => $row['location'] ?? '',
          'privacy' => (string)($row['privacy'] ?? 'public'),
        ];
        $entity_type = 'event';
        $badges = [];
        if (!empty($row['community_name'])) {
            $badges[] = [
                'label' => (string)$row['community_name'],
                'class' => 'app-badge-secondary',
            ];
        }
        $badges[] = [
            'label' => 'Public',
            'class' => 'app-badge-public',
        ];
        $stats = [];
        $actions = [
            ['label' => 'View Event', 'url' => '/events/' . (string)($row['slug'] ?? '')],
        ];
        $description = (string)($row['description'] ?? '');
        include __DIR__ . '/partials/entity-card.php';
      endforeach; ?>
    </div>
  <?php else: ?>
    <div class="app-card">
      <div class="app-card-body">
        <p class="app-text-muted">No public events are listed right now.</p>
      </div>
    </div>
  <?php endif; ?>
</section>

<section class="app-section">
  <div class="app-flex app-flex-between app-mb-4">
    <div>
      <h2 class="app-heading app-heading-md">Public Communities</h2>
      <p class="app-text-muted">Communities that welcome discovery before membership.</p>
    </div>
    <a class="app-btn app-btn-sm" href="/communities">All Communities</a>
  </div>

  <?php if ($featured_communities !== []): ?>
    <div class="app-grid">
      <?php foreach ($featured_communities as $row):
        $entity = (object)[
          'id' => (int)($row['id'] ?? 0),
          'name' => (string)($row['title'] ?? ''),
          'slug' => (string)($row['slug'] ?? ''),
          'created_at' => $row['created_at'] ?? null,
          'description' => $row['description'] ?? '',
        ];
        $entity_type = 'community';
        $badges = [
          [
            'label' => 'Public',
            'class' => 'app-badge-public',
          ],
        ];
        $stats = [
          ['value' => (int)($row['member_count'] ?? 0), 'label' => 'Members'],
          ['value' => (int)($row['event_count'] ?? 0), 'label' => 'Events'],
        ];
        $actions = [
          ['label' => 'View Community', 'url' => '/communities/' . (string)($row['slug'] ?? '')],
        ];
        $description = (string)($row['description'] ?? '');
        include __DIR__ . '/partials/entity-card.php';
      endforeach; ?>
    </div>
  <?php else: ?>
    <div class="app-card">
      <div class="app-card-body">
        <p class="app-text-muted">No public communities are listed right now.</p>
      </div>
    </div>
  <?php endif; ?>
</section>
