import { useBackend } from '../backend';
import { Button, LabeledList, Section } from '../components';
import { Window } from '../layouts';

export const ProximitySensor = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    minutes,
    seconds,
    timing,
    scanning,
    sensitivity,
  } = data;
  return (
    <Window
      width={250}
      height={175}>
      <Window.Content>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Состояние">
              <Button
                icon={scanning ? 'lock' : 'unlock'}
                content={scanning ? 'Готов' : 'Не готов'}
                selected={scanning}
                onClick={() => act('scanning')} />
            </LabeledList.Item>
            <LabeledList.Item label="Радиус">
              <Button
                icon="backward"
                disabled={scanning}
                onClick={() => act('sense', { range: -1 })} />
              {' '}
              {String(sensitivity).padStart(1, '1')}
              {' '}
              <Button
                icon="forward"
                disabled={scanning}
                onClick={() => act('sense', { range: 1 })} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title="Авто-готовность"
          buttons={(
            <Button
              icon={"clock-o"}
              content={timing ? 'Стоп' : 'Старт'}
              selected={timing}
              disabled={scanning}
              onClick={() => act('time')} />
          )}>
          <Button
            icon="fast-backward"
            disabled={scanning || timing}
            onClick={() => act('input', { adjust: -30 })} />
          <Button
            icon="backward"
            disabled={scanning || timing}
            onClick={() => act('input', { adjust: -1 })} />
          {' '}
          {String(minutes).padStart(2, '0')}:
          {String(seconds).padStart(2, '0')}
          {' '}
          <Button
            icon="forward"
            disabled={scanning || timing}
            onClick={() => act('input', { adjust: 1 })} />
          <Button
            icon="fast-forward"
            disabled={scanning || timing}
            onClick={() => act('input', { adjust: 30 })} />
        </Section>
      </Window.Content>
    </Window>
  );
};
