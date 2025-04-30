<span>Maravillosa boda de Karen & Ben</span>
<form method="POST" action="/confirmar">
    @csrf
    <input type="text" name="nombre" placeholder="Tu nombre" required>
    <select name="asistencia">
      <option value="Asistiré">Asistiré</option>
      <option value="No podré asistir">No podré asistir</option>
    </select>
    <button type="submit">Confirmar</button>
  </form>
  