# Phase 17: App Store Publishing

## Objective

Publish GlassHub to the Mac App Store with compliant metadata, privacy disclosures, review notes, screenshots, signing, and phased release controls.

## Scope

- App Store Connect app record.
- Bundle ID, signing, certificates, provisioning, capabilities, and entitlements.
- App Privacy labels.
- Export compliance.
- Screenshots, preview media, category, keywords, subtitle, promotional text, and description.
- Review notes and test account instructions.
- TestFlight validation and phased release.

## Implementation Tasks

- Audit entitlements against actual app behavior.
- Confirm sandbox file-access behavior and explain it clearly in review notes.
- Prepare privacy labels for GitHub account data, repository metadata, diagnostics, and analytics.
- Prepare screenshots for required Mac sizes.
- Create review notes explaining OAuth device flow, local repository access, GitHub Enterprise support, and offline functionality.
- Upload build through Xcode Organizer or Transporter.
- Run TestFlight external review before production submission.
- Configure phased release and rollback/support plan.

## Acceptance Criteria

- App Store Connect metadata matches the app exactly.
- Privacy labels match code and network behavior.
- Review team can test without special private data.
- Production release has a support contact, privacy policy, and release evidence.

## Existing Skills To Apply

- `app-store-review`
- `deployment-release-engineering`
- `cicd-pipeline-design`

## Risks

- App Store Review may question repository scanning, file access, or GitHub authentication.
- Sparkle or direct-download update code must not ship in the App Store build.
- Privacy claims must be conservative and verifiable.
