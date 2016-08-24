require "active_record"

module RetryableFindOrCreateBy
  def find_or_create_by(attributes, &block)
    super
  rescue ActiveRecord::RecordNotUnique
    super
  end

  def find_or_create_by!(attributes, &block)
    super
  rescue ActiveRecord::RecordNotUnique
    super
  end

  def first_or_create(attributes = nil, &block)
    super
  rescue ActiveRecord::RecordNotUnique
    super
  end

  def first_or_create!(attributes = nil, &block)
    super
  rescue ActiveRecord::RecordNotUnique
    super
  end
end

module ActiveRecord
  class Relation
    prepend RetryableFindOrCreateBy
  end
end
