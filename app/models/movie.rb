class Movie < ApplicationRecord
  def self.all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end

  def self.with_ratings(ratings_list)
    return all if ratings_list.blank?
    where('UPPER(rating) IN (?)', ratings_list.map(&:upcase))
  end

  def self.sorted_by(column)
    return all unless %w[title release_date].include?(column)
    if column == 'title' && connection.adapter_name =~ /postg/i
      order(Arel.sql('title COLLATE "C"'))
    else
      order(column)
    end
  end
end
