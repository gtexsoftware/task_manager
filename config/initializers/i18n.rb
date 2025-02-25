class CustomI18nBackend < I18n::Backend::Simple
  def lookup(locale, key, scope = [], options = EMPTY_HASH)
    original_scope = scope
    scope = [ :crm ] + Array(scope)

    super || super(locale, key, original_scope, options)
  end
end

I18n.backend = CustomI18nBackend.new
