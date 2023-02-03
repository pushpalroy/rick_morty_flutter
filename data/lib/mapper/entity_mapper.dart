abstract class EntityMapper<Domain, Data> {
  Domain mapToDomain(Data entity);
  Data mapToData(Domain model);
}