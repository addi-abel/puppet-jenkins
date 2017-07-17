# == Class jenkins::pluginlist
# ===========================
#
#
# Description of the Class:
#
#   This class is meant to be called from init.pp only.
#
#
#
#   *****   this is NOT, I repeat NOT in a random order ...   *****
#                   ===           ===
#
#   *****   http://updates.jenkins-ci.org/download/plugins/   *****
#
#
#
# ===========================
#
class jenkins::pluginlist {

  $plugins  = [
    'display-url-api',
    'mailer',
    'pam-auth',
    'javadoc',
    'structs',
    'junit',
    'token-macro',
    'maven-plugin',
    'credentials',
    'plain-credentials',
    'ssh-credentials',
    'scm-api',
    'mapdb-api',
    'workflow-step-api',
    'workflow-scm-step',
    'subversion',
    'script-security',
    'matrix-project',
    'run-condition',
    'conditional-buildstep',
    'parameterized-trigger',
    'envinject-api',
    'envinject',
    'ant',
    'backup',
    'authentication-tokens',
    'bouncycastle-api',
    'cloudbees-folder',
    'branch-api',
    'copyartifact',
    'jquery',
    'build-pipeline-plugin',
    'build-timeout',
    'credentials-binding',
    'durable-task',
    'email-ext',
    'built-on-column',
    'jenkins-multijob-plugin',
    'workflow-api',
    'workflow-support',
    'pipeline-input-step',
    'workflow-job',
    'workflow-basic-steps',
    'workflow-durable-task-step',
    'jquery-detached',
    'ace-editor',
    'workflow-cps',
    'git-client',
    'git-server',
    'git',
    'workflow-cps-global-lib',
    'workflow-multibranch',
    'momentjs',
    'handlebars',
    'pipeline-stage-step',
    'pipeline-graph-analysis',
    'pipeline-rest-api',
    'pipeline-stage-view',
    'jackson2-api',
    'github-api',
    'github',
    'github-branch-source',
    'pipeline-github-lib',
    'github-organization-folder',
    'gitlab-plugin',
    'gitlab-oauth',
    'global-build-stats',
    'pipeline-build-step',
    'pipeline-milestone-step',
    'pipeline-model-api',
    'pipeline-model-extensions',
    'pipeline-model-declarative-agent',
    'pipeline-stage-tags-metadata',
    'icon-shim',
    'docker-commons',
    'docker-workflow',
    'pipeline-model-definition',
    'workflow-aggregator',
    'external-monitor-job',
    'favorite',
    'gradle',
    'job-dsl',
    'ldap',
    'matrix-auth',
    'metrics',
    'monitoring',
    'multiple-scms',
    'powershell',
    'pubsub-light',
    'resource-disposer',
    'scriptler',
    'sse-gateway',
    'ssh-slaves',
    'support-core',
    'thinBackup',
    'timestamper',
    'uno-choice',
    'variant',
    'windows-slaves',
    'ws-cleanup',
    'antisamy-markup-formatter',
    'active-directory',
    'groovy',
  ]

}
