/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (aarch64)
--
-- Host: 127.0.0.1    Database: social_elonara
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_interactions`
--

DROP TABLE IF EXISTS `ai_interactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ai_interactions` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_id` mediumint(9) DEFAULT NULL,
  `interaction_type` varchar(50) NOT NULL,
  `prompt_text` text DEFAULT NULL,
  `response_text` longtext DEFAULT NULL,
  `tokens_used` int(11) DEFAULT 0,
  `cost_cents` int(11) DEFAULT 0,
  `provider` varchar(20) DEFAULT 'openai',
  `model` varchar(50) DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `event_id` (`event_id`),
  KEY `interaction_type` (`interaction_type`),
  KEY `created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `analytics`
--

DROP TABLE IF EXISTS `analytics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `analytics` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `event_id` mediumint(9) NOT NULL,
  `metric_name` varchar(50) NOT NULL,
  `metric_value` varchar(255) NOT NULL,
  `metric_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `event_id` (`event_id`),
  KEY `metric_name` (`metric_name`),
  KEY `metric_date` (`metric_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `at_protocol_sync`
--

DROP TABLE IF EXISTS `at_protocol_sync`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `at_protocol_sync` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` mediumint(9) NOT NULL,
  `sync_type` varchar(50) NOT NULL,
  `at_protocol_uri` varchar(255) DEFAULT '',
  `sync_status` varchar(20) DEFAULT 'pending',
  `sync_data` longtext DEFAULT NULL,
  `error_message` text DEFAULT NULL,
  `attempts` int(11) DEFAULT 0,
  `last_attempt_at` datetime DEFAULT NULL,
  `synced_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`),
  KEY `sync_type` (`sync_type`),
  KEY `sync_status` (`sync_status`),
  KEY `at_protocol_uri` (`at_protocol_uri`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `at_protocol_sync_log`
--

DROP TABLE IF EXISTS `at_protocol_sync_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `at_protocol_sync_log` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(50) NOT NULL,
  `entity_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `action` varchar(50) NOT NULL,
  `at_uri` varchar(255) DEFAULT '',
  `success` tinyint(1) DEFAULT 0,
  `error_message` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `entity_type` (`entity_type`),
  KEY `entity_id` (`entity_id`),
  KEY `user_id` (`user_id`),
  KEY `action` (`action`),
  KEY `success` (`success`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `communities`
--

DROP TABLE IF EXISTS `communities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `communities` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `type` varchar(50) DEFAULT 'standard',
  `privacy` varchar(20) DEFAULT 'public',
  `personal_owner_user_id` bigint(20) unsigned DEFAULT NULL,
  `member_count` int(11) DEFAULT 0,
  `event_count` int(11) DEFAULT 0,
  `creator_id` bigint(20) unsigned NOT NULL,
  `creator_email` varchar(100) NOT NULL,
  `featured_image` longtext DEFAULT NULL,
  `featured_image_alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `settings` longtext DEFAULT NULL,
  `at_protocol_did` varchar(255) DEFAULT NULL,
  `at_protocol_handle` varchar(255) DEFAULT '',
  `at_protocol_data` longtext DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `requires_approval` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  UNIQUE KEY `at_protocol_did` (`at_protocol_did`),
  KEY `creator_id` (`creator_id`),
  KEY `privacy` (`privacy`),
  KEY `type` (`type`),
  KEY `is_active` (`is_active`),
  KEY `personal_owner_user_id` (`personal_owner_user_id`),
  KEY `created_by` (`created_by`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community_events`
--

DROP TABLE IF EXISTS `community_events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `community_events` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `community_id` mediumint(9) NOT NULL,
  `event_id` mediumint(9) NOT NULL,
  `organizer_member_id` mediumint(9) NOT NULL,
  `visibility` varchar(20) DEFAULT 'community',
  `member_permissions` varchar(50) DEFAULT 'view_rsvp',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_community_event` (`community_id`,`event_id`),
  KEY `community_id` (`community_id`),
  KEY `event_id` (`event_id`),
  KEY `organizer_member_id` (`organizer_member_id`),
  KEY `visibility` (`visibility`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community_invitations`
--

DROP TABLE IF EXISTS `community_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `community_invitations` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `community_id` mediumint(9) NOT NULL,
  `invited_by_member_id` mediumint(9) NOT NULL,
  `invited_email` varchar(100) NOT NULL,
  `invited_user_id` bigint(20) unsigned DEFAULT NULL,
  `invitation_token` varchar(64) NOT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `expires_at` datetime NOT NULL,
  `responded_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `accepted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitation_token` (`invitation_token`),
  KEY `community_id` (`community_id`),
  KEY `invited_by_member_id` (`invited_by_member_id`),
  KEY `invited_email` (`invited_email`),
  KEY `invited_user_id` (`invited_user_id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `community_members`
--

DROP TABLE IF EXISTS `community_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `community_members` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `community_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `email` varchar(100) NOT NULL,
  `display_name` varchar(100) NOT NULL,
  `role` varchar(50) DEFAULT 'member',
  `permissions` longtext DEFAULT NULL,
  `status` enum('active','pending','blocked') NOT NULL DEFAULT 'active',
  `at_protocol_did` varchar(255) DEFAULT '',
  `joined_at` datetime DEFAULT current_timestamp(),
  `last_seen_at` datetime DEFAULT current_timestamp(),
  `invitation_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_member` (`community_id`,`user_id`,`email`),
  UNIQUE KEY `unique_membership` (`community_id`,`user_id`),
  UNIQUE KEY `community_user` (`community_id`,`user_id`),
  KEY `community_id` (`community_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `role` (`role`),
  KEY `status` (`status`),
  KEY `at_protocol_did` (`at_protocol_did`),
  KEY `community_user_status` (`community_id`,`user_id`,`status`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `config` (
  `option_name` varchar(191) NOT NULL,
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) DEFAULT 'yes',
  PRIMARY KEY (`option_name`),
  KEY `autoload` (`autoload`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversation_follows`
--

DROP TABLE IF EXISTS `conversation_follows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation_follows` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `conversation_id` mediumint(9) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `email` varchar(100) NOT NULL,
  `last_read_at` datetime DEFAULT current_timestamp(),
  `notification_frequency` varchar(20) DEFAULT 'immediate',
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_follow` (`conversation_id`,`user_id`,`email`),
  KEY `conversation_id` (`conversation_id`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversation_replies`
--

DROP TABLE IF EXISTS `conversation_replies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation_replies` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `conversation_id` mediumint(9) NOT NULL,
  `parent_reply_id` mediumint(9) DEFAULT NULL,
  `content` longtext NOT NULL,
  `image_url` varchar(500) DEFAULT NULL,
  `image_alt` varchar(255) DEFAULT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `author_email` varchar(100) NOT NULL,
  `depth_level` int(11) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `conversation_id` (`conversation_id`),
  KEY `parent_reply_id` (`parent_reply_id`),
  KEY `author_id` (`author_id`),
  KEY `created_at` (`created_at`),
  KEY `conversation_created_at` (`conversation_id`,`created_at`),
  KEY `conversation_created` (`conversation_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversation_topics`
--

DROP TABLE IF EXISTS `conversation_topics`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversation_topics` (
  `icon` varchar(10) DEFAULT '',
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(11) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `sort_order` (`sort_order`),
  KEY `is_active` (`is_active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversations`
--

DROP TABLE IF EXISTS `conversations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `conversations` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `event_id` mediumint(9) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `author_id` bigint(20) unsigned NOT NULL,
  `author_name` varchar(100) NOT NULL,
  `author_email` varchar(100) NOT NULL,
  `is_pinned` tinyint(1) DEFAULT 0,
  `is_locked` tinyint(1) DEFAULT 0,
  `reply_count` int(11) DEFAULT 0,
  `last_reply_date` datetime DEFAULT current_timestamp(),
  `last_reply_author` varchar(100) DEFAULT '',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `community_id` mediumint(9) DEFAULT NULL,
  `privacy` varchar(20) DEFAULT 'public',
  `featured_image` longtext DEFAULT NULL,
  `featured_image_alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `event_id` (`event_id`),
  KEY `author_id` (`author_id`),
  KEY `is_pinned` (`is_pinned`),
  KEY `last_reply_date` (`last_reply_date`),
  KEY `community_id` (`community_id`),
  KEY `community_created_at` (`community_id`,`created_at`),
  KEY `community_created` (`community_id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `email_verification_tokens`
--

DROP TABLE IF EXISTS `email_verification_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `email_verification_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `email` varchar(100) NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `verified_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `user_id` (`user_id`),
  KEY `email` (`email`),
  KEY `expires_at` (`expires_at`),
  KEY `verified_at` (`verified_at`),
  CONSTRAINT `email_verification_tokens_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `event_invitations`
--

DROP TABLE IF EXISTS `event_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_invitations` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `event_id` mediumint(9) NOT NULL,
  `invited_by_user_id` bigint(20) unsigned NOT NULL,
  `invited_email` varchar(100) NOT NULL,
  `invited_user_id` bigint(20) unsigned DEFAULT NULL,
  `invitation_token` varchar(64) NOT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `custom_message` text DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `responded_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `invitation_token` (`invitation_token`),
  UNIQUE KEY `unique_event_invitation` (`event_id`,`invited_email`,`status`),
  KEY `event_id` (`event_id`),
  KEY `invited_by_user_id` (`invited_by_user_id`),
  KEY `invited_email` (`invited_email`),
  KEY `invited_user_id` (`invited_user_id`),
  KEY `status` (`status`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `excerpt` text DEFAULT NULL,
  `event_date` datetime DEFAULT NULL,
  `event_time` varchar(20) DEFAULT '',
  `end_date` datetime DEFAULT NULL,
  `all_day` tinyint(1) DEFAULT 0,
  `recurrence_type` varchar(20) DEFAULT 'none',
  `recurrence_interval` int(11) DEFAULT 1,
  `recurrence_days` varchar(255) DEFAULT '',
  `monthly_type` varchar(20) DEFAULT 'date',
  `monthly_week` varchar(20) DEFAULT '',
  `monthly_day` varchar(20) DEFAULT '',
  `guest_limit` int(11) DEFAULT 0,
  `venue_info` text DEFAULT NULL,
  `host_email` varchar(100) DEFAULT '',
  `host_notes` text DEFAULT NULL,
  `ai_plan` longtext DEFAULT NULL,
  `event_status` varchar(20) DEFAULT 'active',
  `author_id` bigint(20) unsigned DEFAULT 1,
  `post_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `community_id` mediumint(9) DEFAULT NULL,
  `featured_image` longtext DEFAULT NULL,
  `featured_image_alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `meta_title` varchar(255) DEFAULT '',
  `meta_description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `delivery_orders` longtext DEFAULT NULL,
  `privacy` varchar(20) DEFAULT 'public',
  `location` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `max_guests` int(11) DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `status` varchar(20) DEFAULT 'active',
  `visibility` varchar(20) DEFAULT 'public',
  `rsvp_deadline` datetime DEFAULT NULL,
  `allow_plus_ones` tinyint(1) DEFAULT 1,
  `auto_approve_rsvps` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `slug` (`slug`),
  KEY `event_date` (`event_date`),
  KEY `event_status` (`event_status`),
  KEY `author_id` (`author_id`),
  KEY `privacy` (`privacy`),
  KEY `community_id` (`community_id`),
  KEY `created_by` (`created_by`),
  KEY `status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `rsvp_token` varchar(64) DEFAULT '',
  `temporary_guest_id` varchar(64) DEFAULT '',
  `converted_user_id` bigint(20) unsigned DEFAULT NULL,
  `event_id` mediumint(9) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT '',
  `status` varchar(20) DEFAULT 'pending',
  `invitation_source` varchar(50) DEFAULT 'direct',
  `dietary_restrictions` text DEFAULT NULL,
  `plus_one` tinyint(1) DEFAULT 0,
  `plus_one_name` varchar(100) DEFAULT '',
  `notes` text DEFAULT NULL,
  `rsvp_date` datetime DEFAULT current_timestamp(),
  `reminder_sent` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_guest_event` (`event_id`,`email`),
  KEY `event_id` (`event_id`),
  KEY `email` (`email`),
  KEY `status` (`status`),
  KEY `rsvp_token` (`rsvp_token`),
  KEY `temporary_guest_id` (`temporary_guest_id`),
  KEY `converted_user_id` (`converted_user_id`),
  KEY `invitation_source` (`invitation_source`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `images`
--

DROP TABLE IF EXISTS `images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uploader_id` bigint(20) unsigned NOT NULL COMMENT 'User who uploaded this image',
  `image_type` varchar(20) NOT NULL COMMENT 'profile, cover, featured, post, reply',
  `urls` longtext DEFAULT NULL COMMENT 'JSON object with all size variant URLs',
  `alt_text` varchar(500) NOT NULL COMMENT 'Required alt text for accessibility',
  `file_path` varchar(500) NOT NULL COMMENT 'Primary file path for reference',
  `file_size` int(10) unsigned DEFAULT NULL COMMENT 'File size in bytes',
  `mime_type` varchar(50) DEFAULT NULL,
  `width` int(10) unsigned DEFAULT NULL COMMENT 'Original image width',
  `height` int(10) unsigned DEFAULT NULL COMMENT 'Original image height',
  `community_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Community this image belongs to',
  `event_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Event this image belongs to',
  `conversation_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Conversation this image belongs to',
  `reply_id` bigint(20) unsigned DEFAULT NULL COMMENT 'Conversation reply this image belongs to',
  `is_community_cover` tinyint(1) DEFAULT 0 COMMENT 'Is this the active community cover?',
  `is_event_cover` tinyint(1) DEFAULT 0 COMMENT 'Is this the active event featured image?',
  `is_profile_image` tinyint(1) DEFAULT 0 COMMENT 'Is this the active user profile image?',
  `is_cover_image` tinyint(1) DEFAULT 0 COMMENT 'Is this the active user cover image?',
  `created_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL COMMENT 'Soft delete timestamp',
  `is_active` tinyint(1) DEFAULT 1 COMMENT 'Quick filter for non-deleted images',
  PRIMARY KEY (`id`),
  KEY `idx_uploader` (`uploader_id`,`created_at`),
  KEY `idx_community` (`community_id`,`created_at`),
  KEY `idx_event` (`event_id`,`created_at`),
  KEY `idx_conversation` (`conversation_id`,`created_at`),
  KEY `idx_community_cover` (`is_community_cover`,`community_id`),
  KEY `idx_event_cover` (`is_event_cover`,`event_id`),
  KEY `idx_profile_image` (`is_profile_image`,`uploader_id`),
  KEY `idx_cover_image` (`is_cover_image`,`uploader_id`),
  KEY `idx_active` (`is_active`,`created_at`),
  CONSTRAINT `fk_images_uploader` FOREIGN KEY (`uploader_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_identities`
--

DROP TABLE IF EXISTS `member_identities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_identities` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `email` varchar(100) NOT NULL,
  `display_name` varchar(255) DEFAULT '',
  `at_protocol_did` varchar(255) NOT NULL DEFAULT '',
  `at_protocol_handle` varchar(255) DEFAULT '',
  `at_protocol_pds` varchar(255) DEFAULT '',
  `at_protocol_data` longtext DEFAULT NULL,
  `public_key` longtext DEFAULT NULL,
  `private_key_encrypted` longtext DEFAULT NULL,
  `cross_site_data` longtext DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `verification_method` varchar(20) DEFAULT 'none',
  `oauth_provider` varchar(64) DEFAULT NULL,
  `oauth_scopes` varchar(255) DEFAULT NULL,
  `last_sync_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `did` varchar(255) DEFAULT '',
  `handle` varchar(255) DEFAULT '',
  `access_jwt` text DEFAULT NULL,
  `refresh_jwt` text DEFAULT NULL,
  `oauth_access_token` longtext DEFAULT NULL,
  `oauth_refresh_token` longtext DEFAULT NULL,
  `oauth_token_expires_at` datetime DEFAULT NULL,
  `oauth_metadata` longtext DEFAULT NULL,
  `oauth_connected_at` datetime DEFAULT NULL,
  `needs_reauth` tinyint(1) NOT NULL DEFAULT 0,
  `oauth_last_error` varchar(255) DEFAULT NULL,
  `pds_url` varchar(255) DEFAULT '',
  `profile_data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `at_protocol_did` (`at_protocol_did`),
  KEY `at_protocol_handle` (`at_protocol_handle`),
  KEY `idx_member_identities_oauth_provider` (`oauth_provider`),
  KEY `is_verified` (`is_verified`),
  KEY `did` (`did`),
  KEY `handle` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `token` varchar(64) NOT NULL,
  `expires_at` datetime NOT NULL,
  `used_at` datetime DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `user_id` (`user_id`),
  KEY `expires_at` (`expires_at`),
  KEY `used_at` (`used_at`),
  CONSTRAINT `password_reset_tokens_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `remember_tokens`
--

DROP TABLE IF EXISTS `remember_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `remember_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `selector` char(24) NOT NULL,
  `validator_hash` char(64) NOT NULL,
  `user_agent` varchar(255) DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `last_used_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `selector_unique` (`selector`),
  KEY `remember_user_idx` (`user_id`),
  KEY `remember_expires_idx` (`expires_at`),
  CONSTRAINT `remember_tokens_user_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `search`
--

DROP TABLE IF EXISTS `search`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `search` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `entity_type` varchar(20) NOT NULL,
  `entity_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` mediumtext NOT NULL,
  `url` varchar(255) NOT NULL,
  `owner_user_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `community_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `event_id` bigint(20) unsigned NOT NULL DEFAULT 0,
  `visibility_scope` varchar(20) NOT NULL DEFAULT 'public',
  `last_activity_at` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `entity_unique` (`entity_type`,`entity_id`),
  KEY `entity_type_idx` (`entity_type`),
  KEY `community_idx` (`community_id`),
  KEY `event_idx` (`event_id`),
  KEY `visibility_idx` (`visibility_scope`),
  KEY `owner_idx` (`owner_user_id`),
  FULLTEXT KEY `ft_search` (`title`,`content`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(128) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `guest_token` varchar(64) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `guest_token` (`guest_token`),
  KEY `expires_at` (`expires_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `social`
--

DROP TABLE IF EXISTS `social`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `social` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `guest_id` mediumint(9) DEFAULT NULL,
  `at_protocol_handle` varchar(255) DEFAULT '',
  `bluesky_did` varchar(255) DEFAULT '',
  `connection_data` longtext DEFAULT NULL,
  `connection_status` varchar(20) DEFAULT 'active',
  `last_sync` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  KEY `guest_id` (`guest_id`),
  KEY `at_protocol_handle` (`at_protocol_handle`),
  KEY `connection_status` (`connection_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_activity_tracking`
--

DROP TABLE IF EXISTS `user_activity_tracking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_activity_tracking` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `activity_type` varchar(50) NOT NULL,
  `item_id` mediumint(9) NOT NULL,
  `last_seen_at` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_tracking` (`user_id`,`activity_type`,`item_id`),
  KEY `user_id` (`user_id`),
  KEY `activity_type` (`activity_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_blocks`
--

DROP TABLE IF EXISTS `user_blocks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_blocks` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `blocker_user_id` bigint(20) unsigned NOT NULL,
  `blocked_user_id` bigint(20) unsigned NOT NULL,
  `reason` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_block` (`blocker_user_id`,`blocked_user_id`),
  KEY `blocker_user_idx` (`blocker_user_id`),
  KEY `blocked_user_idx` (`blocked_user_id`),
  CONSTRAINT `fk_user_blocks_blocked` FOREIGN KEY (`blocked_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_blocks_blocker` FOREIGN KEY (`blocker_user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_circle_cache`
--

DROP TABLE IF EXISTS `user_circle_cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_circle_cache` (
  `user_id` bigint(20) unsigned NOT NULL,
  `circle_json` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT 'Cached hop layers: {"inner":[2,3],"trusted":[4,5],"extended":[6]}' CHECK (json_valid(`circle_json`)),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`user_id`),
  CONSTRAINT `fk_circle_cache_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Optional cache of computed hop-distance circles';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_invitations`
--

DROP TABLE IF EXISTS `user_invitations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_invitations` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `inviter_id` bigint(20) unsigned NOT NULL,
  `invitee_email` varchar(100) NOT NULL,
  `invitee_id` bigint(20) unsigned DEFAULT NULL,
  `token` varchar(64) NOT NULL,
  `message` text DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `responded_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `token` (`token`),
  KEY `idx_inviter` (`inviter_id`),
  KEY `idx_invitee_email` (`invitee_email`),
  KEY `idx_invitee_id` (`invitee_id`),
  KEY `idx_status` (`status`),
  CONSTRAINT `fk_user_inv_inviter` FOREIGN KEY (`inviter_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='User-to-user connection invitations';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_links`
--

DROP TABLE IF EXISTS `user_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_links` (
  `user_id` bigint(20) unsigned NOT NULL,
  `peer_id` bigint(20) unsigned NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`user_id`,`peer_id`),
  KEY `idx_peer` (`peer_id`,`user_id`),
  CONSTRAINT `fk_user_links_peer` FOREIGN KEY (`peer_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_user_links_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='Bidirectional user trust graph for circle relationships';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `user_profiles`
--

DROP TABLE IF EXISTS `user_profiles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_profiles` (
  `id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `display_name` varchar(255) DEFAULT '',
  `bio` text DEFAULT NULL,
  `location` varchar(255) DEFAULT '',
  `profile_image` varchar(255) DEFAULT '',
  `profile_image_alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `cover_image` varchar(255) DEFAULT '',
  `cover_image_alt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '',
  `website_url` varchar(255) DEFAULT '',
  `social_links` longtext DEFAULT NULL,
  `hosting_preferences` longtext DEFAULT NULL,
  `notification_preferences` longtext DEFAULT NULL,
  `privacy_settings` longtext DEFAULT NULL,
  `events_hosted` int(11) DEFAULT 0,
  `events_attended` int(11) DEFAULT 0,
  `host_rating` decimal(3,2) DEFAULT 0.00,
  `host_reviews_count` int(11) DEFAULT 0,
  `available_times` longtext DEFAULT NULL,
  `dietary_restrictions` text DEFAULT NULL,
  `accessibility_needs` text DEFAULT NULL,
  `is_verified` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `last_active` datetime DEFAULT current_timestamp(),
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `avatar_source` varchar(20) DEFAULT 'gravatar',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`),
  KEY `display_name` (`display_name`),
  KEY `location` (`location`),
  KEY `is_verified` (`is_verified`),
  KEY `is_active` (`is_active`),
  KEY `last_active` (`last_active`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_520_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(60) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `display_name` varchar(250) NOT NULL,
  `bio` text DEFAULT NULL,
  `avatar_url` varchar(500) DEFAULT NULL,
  `avatar_preference` varchar(20) DEFAULT 'auto' COMMENT 'Avatar source preference: auto, custom, gravatar',
  `avatar_alt` varchar(255) DEFAULT NULL,
  `cover_url` varchar(500) DEFAULT NULL,
  `cover_alt` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'active',
  `role` varchar(20) DEFAULT 'member',
  `created_at` datetime DEFAULT current_timestamp(),
  `last_login_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`),
  KEY `status` (`status`),
  KEY `role` (`role`),
  KEY `idx_avatar_preference` (`avatar_preference`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-28 10:20:05
