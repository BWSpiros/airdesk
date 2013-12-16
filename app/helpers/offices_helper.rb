module OfficesHelper
  def build_ridiculous_query(features)
    rec_query(features.length) + " WHERE feature_id=?"
  end

  def rec_query(i)
    if i <= 1
      "SELECT DISTINCT offices.* FROM offices JOIN featurings ON featurings.office_id = offices.id"
    else
      expo = rec_query(i-1)
      expo + " JOIN (SELECT DISTINCT offices.* FROM offices JOIN featurings ON featurings.office_id = offices.id WHERE feature_id=?) as o#{i} ON offices.id = o#{i}.id"
    end
  end

end

# "SELECT DISTINCT offices.* FROM offices JOIN featurings ON featurings.office_id = offices.id JOIN (SELECT DISTINCT offices.* FROM offices
# JOIN featurings ON featurings.office_id = offices.id WHERE feature_id=?) as o2 ON offices.id = o2.id JOIN (SELECT DISTINCT offices.* FROM offices
# JOIN featurings ON featurings.office_id = offices.id WHERE feature_id=?) as o3 ON offices.id = o3.id WHERE feature_id=?"