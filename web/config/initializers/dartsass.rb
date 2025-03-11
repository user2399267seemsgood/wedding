# Do not print deprecation warnings. There are a lot...
Rails.application.config.dartsass.build_options << "--quiet"

Rails.application.config.dartsass.builds = {
    'application.scss'                                      => 'application.css',
    'gifts.scss'                                            => 'gifts.css',
    '../../../vendor/assets/stylesheets/active_admin.scss'  => 'active_admin.css'
}
