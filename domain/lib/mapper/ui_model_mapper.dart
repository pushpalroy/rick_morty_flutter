abstract class UiModelMapper<Dom, UI> {
  UI mapToPresentation(Dom model);
  Dom mapToDomain(UI modelItem);
}
