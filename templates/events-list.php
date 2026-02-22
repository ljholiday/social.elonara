<?php
/** @var array<int,array<string,mixed>> $events */
/** @var array<int,array<string,mixed>> $past_events */
/** @var string $filter */

$filter = $filter ?? 'all';
$past_events = $past_events ?? [];
?>
<section class="app-section">
  <h1 class="app-heading">Upcoming Events</h1>

  <?php
  $card_path = __DIR__ . '/partials/entity-card.php';
  if (!is_file($card_path)) {
      echo '<p class="app-text-muted">Entity card partial not found at templates/partials/entity-card.php</p>';
      return;
  }
  ?>

  <?php if (!empty($events)) : ?>
    <div class="app-grid">
      <?php foreach ($events as $row):
        $slug = $row['slug'] ?? (string)($row['id'] ?? '');
        $privacy = strtolower((string)($row['privacy'] ?? 'public'));
        $contextLabel = (string)($row['context_label'] ?? '');

        $entity = (object)[
          'id' => (int)($row['id'] ?? 0),
          'title' => $contextLabel !== '' ? $contextLabel : (string)($row['title'] ?? ''),
          'slug' => $slug,
          'event_date' => $row['event_date'] ?? null,
          'end_date' => $row['end_date'] ?? null,
          'description' => $row['description'] ?? '',
          'venue_info' => $row['location'] ?? '',
          'privacy' => $privacy,
        ];

        $entity_type = 'event';

        $badges = [];
        if ($contextLabel !== '') {
            $badges[] = [
                'label' => $contextLabel,
                'class' => 'app-badge-secondary',
            ];
        }
        $badges[] = [
            'label' => ucfirst($privacy),
            'class' => $privacy === 'private' ? 'app-badge-private' : 'app-badge-public',
        ];

        $stats = [];

        $actions = [
            [
                'label' => 'View',
                'url' => '/events/' . $slug,
            ],
        ];

        $description = $row['description'] ?? '';

        include __DIR__ . '/partials/entity-card.php';
      endforeach; ?>
    </div>
  <?php else: ?>
    <div class="app-card">
      <div class="app-card-body app-text-center">
        <?php if ($filter === 'my'): ?>
          <p class="app-text-muted">You don't have any upcoming events yet. Plan your first event or check out what others are organizing!</p>
          <div class="app-flex app-flex-wrap">
            <a class="app-btn app-btn-primary" href="/events/create">Create Event</a>
            <a class="app-btn" href="/events?filter=all">Browse All Events</a>
          </div>
        <?php else: ?>
          <p class="app-text-muted">No events found. Be the first to create one!</p>
          <a class="app-btn app-btn-primary" href="/events/create">Create Event</a>
        <?php endif; ?>
      </div>
    </div>
  <?php endif; ?>

  <?php if (!empty($past_events)) : ?>
    <div class="app-mt-4">
      <button type="button" class="app-btn app-btn-secondary app-btn-block" data-toggle-past-events>
        Show past events
      </button>
      <div data-past-events style="display: none;">
        <div class="app-grid">
          <?php foreach ($past_events as $row):
            $slug = $row['slug'] ?? (string)($row['id'] ?? '');
            $privacy = strtolower((string)($row['privacy'] ?? 'public'));
            $contextLabel = (string)($row['context_label'] ?? '');

            $entity = (object)[
              'id' => (int)($row['id'] ?? 0),
              'title' => $contextLabel !== '' ? $contextLabel : (string)($row['title'] ?? ''),
              'slug' => $slug,
              'event_date' => $row['event_date'] ?? null,
              'end_date' => $row['end_date'] ?? null,
              'description' => $row['description'] ?? '',
              'venue_info' => $row['location'] ?? '',
              'privacy' => $privacy,
            ];

            $entity_type = 'event';

            $badges = [];
            if ($contextLabel !== '') {
                $badges[] = [
                    'label' => $contextLabel,
                    'class' => 'app-badge-secondary',
                ];
            }
            $badges[] = [
                'label' => ucfirst($privacy),
                'class' => $privacy === 'private' ? 'app-badge-private' : 'app-badge-public',
            ];

            $stats = [];

            $actions = [
                [
                    'label' => 'View',
                    'url' => '/events/' . $slug,
                ],
            ];

            $description = $row['description'] ?? '';

            include __DIR__ . '/partials/entity-card.php';
          endforeach; ?>
        </div>
      </div>
    </div>
  <?php endif; ?>
</section>
